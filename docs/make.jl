using ExchangeRates
using Documenter

DocMeta.setdocmeta!(ExchangeRates, :DocTestSetup, :(using ExchangeRates); recursive=true)

makedocs(;
    modules=[ExchangeRates],
    authors="Thomas Poulsen <ta.poulsen@gmail.com> and contributors",
    repo="https://github.com/tp2750/ExchangeRates.jl/blob/{commit}{path}#{line}",
    sitename="ExchangeRates.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tp2750.github.io/ExchangeRates.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/tp2750/ExchangeRates.jl",
    devbranch="main",
)
