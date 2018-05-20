module Sensor where
  import Map

  setToGreen :: Sensor -> Sensor
  setToGreen (Sensor id x y conn_id cars pieds delta state) = (Sensor id x y conn_id cars pieds 0 Green)

  setToRed :: Sensor -> Sensor
  setToRed (Sensor id x y conn_id cars pieds delta state) = (Sensor id x y conn_id cars pieds 0 Red)

  incrDelta :: Sensor -> Int -> Sensor
  incrDelta (Sensor id x y conn_id cars pieds delta state) d = (Sensor id x y conn_id cars pieds (delta + fromIntegral d) state)

  id :: Sensor -> Int
  id (Sensor id x y conn_id cars pieds delta state) = id

  getStateString :: Sensor -> String
  getStateString (Sensor id x y conn_id cars pieds delta state) = case state of
    Red -> "RED"
    Orange -> "ORANGE"
    Green -> "GREEN"

  toJSON :: Sensor -> String
  toJSON sensor = "{\"state\":\"" ++ (getStateString sensor) ++ "\", \"id\":" ++ (show $ Sensor.id sensor) ++ "}\n"
