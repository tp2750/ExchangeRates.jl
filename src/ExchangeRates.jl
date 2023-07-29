module ExchangeRates

using EzXML
using HTTP

include("fromto.jl")
export exchage_rates, fromto, refresh

include("consts.jl")
# exports EUR, USD, DKK etc


end
