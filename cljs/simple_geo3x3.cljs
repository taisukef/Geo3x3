(ns cljs.simple_geo3x3
    (:require [cljs.geo3x3 :as geo3x3])
)

(println (geo3x3/encode 35.65858 139.745433 14))
(println (geo3x3/decode "E9139659937288"))
(println (geo3x3/decode "W9"))
