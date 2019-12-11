using JuMP, Cbc


# Initialize model
m = Model(with_optimizer(Cbc.Optimizer))

# contract stipulations
contract_demand = [520, 720, 520, 620]

# incorporate constants into our model
permanent_units_per_month = 10 * 12

# reflect permanent_units_per_month on contract_demand
remaining_demand = contract_demand .- permanent_units_per_month

# Initialize our Decision Variables
@variable(m,x[i=1:4] >= 0, base_name ="Net # of temps at start of month AFTER hiring/firing D.V.")
@variable(m,S_hire[i=1:4] >= 0, base_name="# of temps to hire at start of month D.V.")
@variable(m, S_fire[i=1:4] >= 0, base_name="# of temps to fire at start of month D.V.")
@variable(m,I[i=1:3] >= 0, base_name="Units of ending inventory D.V.")

# Initiate number of units produced at each month as we did in problem 1
use = cat(0,I;dims = 1)
store = cat(I,0;dims = 1)

meeting_contract_demands = use .+ 10x .- store

@expression(m, con, meeting_contract_demands)
@constraint(m, con .== remaining_demand)

# Model hiring/firing process
workers = cat(0,x[1:3];dims = 1)
hiring_firing = (S_hire .- S_fire) .+ workers
@expression(m, con2, hiring_firing)
@constraint(m, con2 .== x)

# Objective is to minimize all types of cost: inventory and hiring/firing
inventory_cost = sum(50I)
hiring_cost = sum(200S_hire)
firing_cost = sum(400S_fire)

@expression(m,obj, inventory_cost + hiring_cost + firing_cost)
@objective(m, Min, obj)

# optimize
optimize!(m)

# attain optimal D.V.
obj = objective_value(m)
println("Objective Value:")
display(obj)
println("Optimal Hiring Variables:")
println(value.(S_hire))
println("Optimal Firing Variables:")
println(value.(S_fire))
println("Optimal Inventory Variables:")
println(value.(I))
