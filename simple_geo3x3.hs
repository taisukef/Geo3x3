module Main (main) where

import Geo3x3

main :: IO ()
main = do
  let code = Geo3x3.encode 35.65858 139.745433 14
  putStrLn code
  let res = Geo3x3.decode "E3793653391822"
  print res

-- E3793653391822
-- (35.658633790016204,139.74540917994665,14,1.1290058538953522e-4)

