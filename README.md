# ExchangeRates

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://tp2750.github.io/ExchangeRates.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://tp2750.github.io/ExchangeRates.jl/dev/)
[![Build Status](https://github.com/tp2750/ExchangeRates.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/tp2750/ExchangeRates.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua QA](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

## Purpose

The purpose of this package is to provide a convenient interface to working with exchange rates.

## Data

The data is downloaded from the European Central Bank, when the package is loaded.

It uses this link: <https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml>.

## Barewords

The simplest interface looks like this:

``` julia
julia> 100EUR/DKK
745.08
```

This shows that you need 745.08 DKK to have 100 EUR.

This is done by defining and exporting variables `EUR`, `USD`, `DKK` etc (using the cool metraprogramming tools of julia).

Each variable is the exchange rate of `EUR`, so `USD` is the value of 1 USD in EUR. This means that `100USD` is the value of 100 USD in EUR.

Note that this uses the juxtaposition syntax of julia, so the can not be a whitespace between the number and the currency without an explicit multiplication:

``` julia
julia> 100 DKK
ERROR: syntax: extra token "DKK" after end of expression

julia> 100 * DKK
13.421377570193805

```

## Listing exchange reates

The exchange rates are stred in the dict `exchange_rates` in the module:

``` julia
julia> sort(ExchangeRates.exchange_rates)
OrderedCollections.OrderedDict{String, Float64} with 34 entries:
  "AUD" => 1.7569
  "BGN" => 1.9558
  "BRL" => 6.4721
  "CAD" => 1.563
  "CHF" => 0.9299
  "CNY" => 8.1197
  "CZK" => 24.915
  "DKK" => 7.4594
  "EUR" => 1.0
  "GBP" => 0.8382
  "HKD" => 8.8508
  "HUF" => 403.55
  "IDR" => 18382.9
  "ILS" => 4.0931
  "INR" => 96.552
  "ISK" => 145.0
  "JPY" => 161.13
  "KRW" => 1555.77
  "MXN" => 21.854
  "MYR" => 4.7815
  "NOK" => 11.522
  "NZD" => 1.9012
  "PHP" => 62.531
  "PLN" => 4.2603
  "RON" => 5.0517
  "SEK" => 10.8348
  "SGD" => 1.4555
  "THB" => 36.779
  "TRY" => 44.108
  "USD" => 1.1301
  "ZAR" => 20.3253
  "£"   => 0.8382
  "¥"   => 161.13
  "€"   => 1.0
```

## Function interface

The package exports a single function `fromto`. 
It gives the conversion rate from the first argument to the second argument.

``` julia
julia> fromto(:EUR,:DKK)*100
745.08
```

## Unicode

The package knows a few unicode currencies:

* `€` (EUR)
* `£` (GBP)
* `¥` (JPY)

but NOT `$`, as `$` has syntactic meaning in julia (string interpolation).

``` julia
julia> 100€/£
86.706

julia> fromto(:EUR,:GBP)*100
86.706
```

# Updating data

Exchange rates are fetched when the module is loaded.
To refresh that data, run `ExchangeRates.refresh()`.

# TODO

Integrate with 

* [Currencies.jl](https://github.com/JuliaFinance/Currencies.jl)
* [UnitfulAssets](https://github.com/rmsrosa/UnitfulAssets.jl)
