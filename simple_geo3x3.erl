-module(simple_geo3x3).
-export([main/0]).

main() ->
    io:format("~s~n", [geo3x3:encode(35.65858, 139.745433, 14)]),
    {Lat, Lng, Level, Unit} = geo3x3:decode("E9139659937288"),
    io:format("~w ~w ~w ~w~n", [Lat, Lng, Level, Unit]).
