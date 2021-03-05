{-# LANGUAGE BangPatterns #-}

module Geo3x3 ( encode'
              , decodeE'
              , decode'
              , encode
              , decodeE
              , decode
              ) where

import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import qualified Data.ByteString.Builder as Builder
import qualified Control.Monad.RWS as RWS
import qualified Control.Monad.State as State
import Control.Monad (forM_, when)
import Data.Function ((&))
import Control.Monad.Except (ExceptT(..),throwError,runExceptT)

type Lat = Double
type Lng = Double
type Level = Int
type Unit = Double

data DecodeError = DecodeEmptyData
                 | DecodeInvalidDigit (Lat,Lng,Level,Unit)
                 deriving (Show)

type Encoder =  RWS.RWS () Builder.Builder (Lat,Lng,Unit)
type Decoder = ExceptT DecodeError (State.State (Lat,Lng,Level,Unit))

encode' :: Lat -> Lng -> Level -> LB8.ByteString
encode' lat lng level = Builder.toLazyByteString $ snd $ RWS.evalRWS f () (0,0,0) -- (lat,lng,unit)
  where
    f :: Encoder ()
    f = if level < 1 then return () -- retuan empty bytes
        else do

          let (!c,!lng') = if lng >= 0
                           then ('E',lng)
                           else ('W',lng + 180)
              !lat' = lat + 90
              !unit = 180
           in do RWS.put $! (lat',lng',unit) -- ignore initial state
                 RWS.tell $! Builder.char7 c

          forM_ [1..level-1] $ \_ -> do
            (lat,lng,unit) <- RWS.get
            let !unit' = unit / 3
                x = floor $ lng / unit'
                y = floor $ lat / unit'
                !c = toEnum $ fromEnum '0' + x + y * 3 + 1
                !lng' = lng - (fromIntegral x) * unit'
                !lat' = lat - (fromIntegral y) * unit'
              in do RWS.put $! (lat',lng',unit')
                    RWS.tell $! Builder.char7 c 


decodeE' :: B8.ByteString -> Either DecodeError (Lat,Lng,Level,Unit)
decodeE' code = State.evalState (runExceptT f) (0,0,1,180) -- (lat,lng,level,unit)
  where
    f :: Decoder (Lat,Lng,Level,Unit)
    f = if B8.null code then throwError DecodeEmptyData
        else

          let (begin,isWest) =
                case B8.index code 0 of
                  c | c == '-' || c == 'W' -> (1,True)
                  c | c == '+' || c == 'E' -> (1,False)
                  _ -> (0,False)

              postProcess = \(lat,lng,level,unit) ->
               let !lat' = lat + unit / 2 & \lat -> lat - 90
                   !lng' = lng + unit / 2 & \lng -> if isWest then lng - 180 else lng
                in (lat',lng',level,unit)

              loop = \i ->
                when (i < B8.length code) $
                  let n = (fromEnum $ B8.index code i) - (fromEnum '0')
                   in if n > 9 then State.get >>= \s -> throwError $ DecodeInvalidDigit $ postProcess s -- halfway result
                   else when (n > 0) $ do
                     State.modify' $ \(lat,lng,level,unit) ->
                       let !unit' = unit / 3
                           (!lng',!lat') = n - 1 & \n ->
                             (lng + (fromIntegral $ n `mod` 3) * unit',
                              lat + (fromIntegral $ n `div` 3) * unit')
                           !level' = level + 1
                        in (lat',lng',level',unit')
                     loop $ i + 1
           in do loop begin
                 State.modify' postProcess
                 State.get


decode' :: B8.ByteString -> (Lat,Lng,Level,Unit)
decode' code = either r id $ decodeE' code
  where
    r :: DecodeError -> (Lat,Lng,Level,Unit)
    r DecodeEmptyData = (0,0,0,0)
    r (DecodeInvalidDigit res) = res -- return halfway result

encode :: Double -> Double -> Int -> String
encode lat lng level = LB8.unpack $ encode' lat lng level

decodeE :: String -> Either DecodeError (Double,Double,Int,Double)
decodeE = decodeE' . B8.pack

decode :: String -> (Double,Double,Int,Double)
decode = decode' . B8.pack
