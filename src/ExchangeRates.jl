module ExchangeRates

using EzXML
using HTTP
# using Scratch

export exchage_rates, fromto, refresh

function __init__()
    include("src/fromto.jl")
    
    include("src/consts.jl")
    # exports EUR, USD, DKK etc
end

end
