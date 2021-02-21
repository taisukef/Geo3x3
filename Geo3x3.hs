module Geo3x3
    ( encode'
    , decode'
    , encode
    , decode
    ) where

import qualified Data.ByteString.Char8 as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Builder as Builder
import Data.ByteString.Builder (Builder)
import qualified Control.Monad.RWS as RWS
import Data.Monoid ((<>))
import Control.Monad (forM_)

type Encoder =  RWS.RWS () Builder (Double,Double,Double) -- lat lng unit

encode' :: Double -> Double -> Int -> LB8.ByteString
encode' lat lng level = Builder.toLazyByteString $ snd $ RWS.evalRWS f () (lat,lng,0)
  where
    f :: Encoder ()
    f  = do
      if level < 1
        then error "invalid level"
        else do
          if lng >= 0
            then RWS.tell $ Builder.char7 'E'
            else do
              RWS.tell $ Builder.char7 'W'
              (lat,lng,unit)<-RWS.get
              RWS.put (lat,lng+180,unit)
          (lat,lng,unit)<-RWS.get
          let lat' = 90 - lat  -- 0:the North Pole,  180:the South Pole
          RWS.put (lat',lng,180)
          forM_ [1..level-1] $ \_ -> do
            (lat,lng,unit) <- RWS.get
            let unit' = unit / 3
            let x = truncate $ lng / unit'
            let y = truncate $ lat / unit'
            RWS.tell $ Builder.char7 $ toEnum $ fromEnum '0' + x + y * 3 + 1
            let lng' = lng - (fromIntegral x) * unit'
            let lat' = lat - (fromIntegral y) * unit'
            RWS.put (lat',lng',unit')


decode' :: B8.ByteString -> (Double, Double, Double, Double)
decode' code = (0.0, 0.0, 0.0, 0.0)

encode :: Double -> Double -> Int -> String
encode lat lng level =  LB8.unpack $ encode' lat lng level

decode :: String -> (Double, Double, Double, Double)
decode = decode' . B8.pack
