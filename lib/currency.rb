class Currency < ActiveRecord::Base
  CODES = {
    "ZMK" => "zmk",
    "USD" => "usd",
    "CAD" => "cad",
    "Airtel Airtime Units" => "airtel_airtime_units",
    "MTN Airtime Units" => "mtn_airtime_units",
    "Zamtel Airtime Units" => "units_airtime_units",
  }
end
