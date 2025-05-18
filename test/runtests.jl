try
    symlink("../src", "src")
catch e
end

using ExchangeRates
using Test


@testset "ExchangeRates.jl" begin
    @test € == EUR == 1.0
    @test abs(100EUR/DKK - 746) <= 1
end
