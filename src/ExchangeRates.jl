module ExchangeRates

using EzXML
using HTTP
# using Scratch # TODO use this to cache values for use off-line?

export exchage_rates, fromto, refresh

function __init__()
    # Update rates at module load-time. From julia v1.10 we can not do it at compiletime
    global exchange_rates = get_rates_dict()

    # Set variables for rates:
    global EUR = 1.0
    eval(Meta.parse(join(["global $(x[1]) = EUR/$(x[2]) " for x in pairs(exchange_rates)], ";")));

    # exports EUR, USD, DKK etc
    eval(Meta.parse(join(["export $x " for x in keys(exchange_rates)], ";")));
end

function get_xml(; url="https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
    @info "Fetching rates from $url"
    r1 = HTTP.get(url, ["Accept" => "application/xml"];status_exception=false) 
    r2 = String(r1.body)
    r2
end

function get_rates_dict(; url="https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
    s1 = get_xml(url=url)
    x1 = EzXML.parsexml(s1)
    d1 = x1.root
    d = Dict("EUR" => 1.0)
    for e in elements(elements(elements(d1)[3])[1])
        d[e["currency"]] = parse(Float64,e["rate"])
    end
    d["€"] = d["EUR"]
    d["£"] = d["GBP"]
    d["¥"] = d["JPY"]
    d
end

function fromto(from, to; exchange_rates = exchange_rates, url="https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
    if !(typeof(exchange_rates) <: Dict)
        exchange_rates = get_rates_dict(url=url)
    end
    exchange_rates[string(to)] / exchange_rates[string(from)]
end

fromto(from::Float64, to::Float64) = to/from

function refresh()
    @info "Updating rates"
    exchange_rates = get_rates_dict()
end


end
