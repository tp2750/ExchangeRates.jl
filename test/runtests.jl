using ExchangeRates
using Test

include("Aqua.jl")

@testset "ExchangeRates.jl" begin
    @test € == EUR == 1.0
    @test abs(100EUR/DKK - 746) <= 1
end
