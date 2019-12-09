using JuMP, Cbc


# Initialize model
m = Model(with_optimizer(Cbc.Optimizer))

# Production D.V.
@variable(m, x[i = 1:4] >= 0, base_name = "Unit Production D.V.")
@variable(m, s[i=1:4] >= 0, base_name="Shortage D.V.")

# Define objective (maximize profit, which can only be done by satisfying contract stipulations to the best of our abilities)
unit_profit = [30 40 20 10]
unit_penalty = [15 20 10 8]

#profit
total_profit = sum(unit_profit *x)
total_penalty = sum(unit_penalty *s)

# objective expression
@expression(m, net_profit, total_profit - total_penalty)
@objective(m, Max, net_profit)

# define production constraints
A = [.30 .30 .25 .15;
     .25 .35 .30 .10;
     .45 .50 .40 .22;
     .15 .15 .10 .05]
b = repeat([1000], 4)
@constraint(m, constraint1, A*x .<= b)

# define shortage constraints
contract_stipulations = [800, 750, 600, 500]
@constraint(m,constraint2, x + s .== contract_stipulations)

# optimize
optimize!(m)

# attain optimal D.V.
obj = objective_value(m)
println("Objective Value:")
display(obj)
println("Optimal Unit Production Variables:")
println(value.(x))
println("Optimal Shortage Variables:")
println(value.(s))
