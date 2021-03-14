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




testEncode :: IO ()
testEncode = do
  print $ encode 35.65858 139.745433 0
  print $ encode  0.0  90.0 1
  print $ encode 60.0 150.0 2
  print $ encode 40.0 130.0 3
  print $ encode 33.3 136.6 4
  print $ encode 35.65858 139.745433 14
  print $ encode 35.65858 139.745433 20

  print $ encode 35.65858 (-139.745433) 0
  print $ encode  0.0 (-  90.0) 1
  print $ encode 60.0 (- 150.0) 2
  print $ encode 40.0 (- 130.0) 3
  print $ encode 33.3 (- 136.6) 4
  print $ encode 35.65858 (-139.745433) 14
  print $ encode 35.65858 (-139.745433) 20


testDecode :: IO ()
testDecode = do
  print $ decode ""
  print $ decode "9"
  print $ decode "91"
  print $ decode "913"
  print $ decode "9139659937288"
  print $ decode "9139659937288123677"

  print $ decode "00000000000000000000"
  print $ decode "90000000000000000000"
  print $ decode "91000000000000000000"
  print $ decode "91300000000000000000"
  print $ decode "91396599372880000000"
  print $ decode "91396599372881236770"

  print $ decode "A"
  print $ decode "9A"
  print $ decode "91A"
  print $ decode "913A"
  print $ decode "9139659937288A"
  print $ decode "9139659937288123677A"

  print $ decode "E"
  print $ decode "E9"
  print $ decode "E91"
  print $ decode "E913"
  print $ decode "E9139659937288"
  print $ decode "E9139659937288123677"

  print $ decode "E00000000000000000000"
  print $ decode "E90000000000000000000"
  print $ decode "E91000000000000000000"
  print $ decode "E91300000000000000000"
  print $ decode "E91396599372880000000"
  print $ decode "E91396599372881236770"

  print $ decode "EA"
  print $ decode "E9A"
  print $ decode "E91A"
  print $ decode "E913A"
  print $ decode "E9139659937288A"
  print $ decode "E9139659937288123677A"

  print $ decode "+"
  print $ decode "+9"
  print $ decode "+91"
  print $ decode "+913"
  print $ decode "+9139659937288"
  print $ decode "+9139659937288123677"

  print $ decode "+00000000000000000000"
  print $ decode "+90000000000000000000"
  print $ decode "+91000000000000000000"
  print $ decode "+91300000000000000000"
  print $ decode "+91396599372880000000"
  print $ decode "+91396599372881236770"

  print $ decode "+A"
  print $ decode "+9A"
  print $ decode "+91A"
  print $ decode "+913A"
  print $ decode "+9139659937288A"
  print $ decode "+9139659937288123677A"


  print $ decode "W"
  print $ decode "W7"
  print $ decode "W73"
  print $ decode "W731"
  print $ decode "W7317457719288"
  print $ decode "W7317457719288321499"

  print $ decode "W00000000000000000000"
  print $ decode "W70000000000000000000"
  print $ decode "W73000000000000000000"
  print $ decode "W73100000000000000000"
  print $ decode "W73174577192880000000"
  print $ decode "W73174577192883214990"

  print $ decode "WA"
  print $ decode "W7A"
  print $ decode "W73A"
  print $ decode "W731A"
  print $ decode "W7317457719288A"
  print $ decode "W7317457719288321499A"

