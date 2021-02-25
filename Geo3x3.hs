{-# LANGUAGE BangPatterns #-}

module Geo3x3 ( encode'
              , decode'
              , encode
              , decode
              ) where

import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import qualified Data.ByteString.Builder as Builder
import qualified Control.Monad.RWS as RWS
import qualified Control.Monad.State as State
import Control.Monad (forM_, when)
import Data.Char (digitToInt)
import Data.Function ((&))

type Lat = Double
type Lng = Double
type Level = Int
type Unit = Double

type Encoder =  RWS.RWS () Builder.Builder (Lat,Lng,Unit)
type Decoder = State.State (Lat,Lng,Level,Unit)

encode' :: Lat -> Lng -> Level -> LB8.ByteString
encode' lat lng level = Builder.toLazyByteString $ snd $ RWS.evalRWS f () (0,0,0) -- (lat,lng,unit)
  where
    f :: Encoder ()
    f = if level < 1 then error "invalid level"
        else do

          let (!c,!lng') = if lng >= 0
                           then ('E',lng)
                           else ('W',lng + 180)
              !lat' = 90 - lat
              !unit = 180
           in do RWS.put $! (lat',lng',unit) -- ignore initial state
                 RWS.tell $! Builder.char7 c

          forM_ [1..level-1] $ \_ -> do
            (lat,lng,unit) <- RWS.get
            let !unit' = unit / 3
                x = truncate $ lng / unit'
                y = truncate $ lat / unit'
                !c = toEnum $ fromEnum '0' + x + y * 3 + 1
                !lng' = lng - (fromIntegral x) * unit'
                !lat' = lat - (fromIntegral y) * unit'
              in do RWS.put $! (lat',lng',unit')
                    RWS.tell $! Builder.char7 c 


decode' :: B8.ByteString -> (Lat,Lng,Level,Unit)
decode' code = State.execState f (0,0,1,180) -- (lat,lng,level,unit)
  where
    f :: Decoder ()
    f = if B8.null code then error "trying to decode empty data"
        else do

          let (begin,isWest) =
                case B8.index code 0 of
                  c | c == '-' || c == 'W' -> (1,True)
                  c | c == '+' || c == 'E' -> (1,False)
                  _ -> (0,False)

          let loop = \i ->
                when (i < B8.length code) $
                  let n = digitToInt $ B8.index code i -- includes hex digits
                   in when (1 <= n && n <= 9) $ do -- [todo] fail when overflow
                     State.modify' $ \(lat,lng,level,unit) ->
                       let !unit' = unit / 3
                           (!lng',!lat') = n - 1 & \n ->
                             (lng + (fromIntegral $ n `mod` 3) * unit',
                              lat + (fromIntegral $ n `div` 3) * unit')
                           !level' = level + 1
                        in (lat',lng',level',unit')
                     loop $ i + 1
           in loop begin

          State.modify' $ \(lat,lng,level,unit) ->
            let !lat' = lat + unit / 2 & \lat -> 90 - lat
                !lng' = lng + unit / 2 & \lng -> if isWest then lng - 180 else lng
             in (lat',lng',level,unit)


encode :: Double -> Double -> Int -> String
encode lat lng level = LB8.unpack $ encode' lat lng level

decode :: String -> (Double,Double,Int,Double)
decode = decode' . B8.pack
