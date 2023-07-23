module ExchangeRates

using EzXML
using HTTP

include("fromto.jl")
export exchage_rates, fromto

include("consts.jl")
# exports EUR, USD, DKK etc


end
