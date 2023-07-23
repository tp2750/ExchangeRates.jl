# Set variables for rates:
global EUR = 1.0
eval(Meta.parse(join(["global $(x[1]) = EUR/$(x[2]) " for x in pairs(exchange_rates)], ";")));

# 100EUR/DKK == 745.08
# 100NOK/DKK == 66.65891299485574

# export
eval(Meta.parse(join(["export $x " for x in keys(exchange_rates)], ";")));
