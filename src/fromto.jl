using EzXML
using HTTP

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

global exchange_rates = get_rates_dict()

function fromto(from, to; exchange_rates = exchange_rates, url="https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml")
    if !(typeof(exchange_rates) <: Dict)
        exchange_rates = get_rates_dict(url=url)
    end
    exchange_rates[string(to)] / exchange_rates[string(from)]
end

function refresh()
    exchange_rates = get_rates_dict()
end
