using JuMP, Cbc

#= Layout of Constraints:
x1 - I1 = 100 Month 1
I1 + x2 - I2 = 250 Month 2
I2 + x3 - I3 = 190 Month 3
I3 + x4 - I4 = 140 Month 4
I4 + x5 - I5 = 220 Month 5
I5 + x6 = 110 Month 6
x_i, i = 1:6, I_i >= 0, i = 1:5
=#



# Initialize model
model = Model(with_optimizer(Cbc.Optimizer))

@variable(model, x[i = 1:6] >= 0, base_name = "Window Variables")
@variable(model, I[i = 1:5] >= 0, base_name = "Inventory Variables")
x,I


cost = [50 45 55 48 52 50]
expr = sum(cost*x) + 8sum(I)

@expression(model, obj, expr)
@objective(model, Min, obj)

# Month to month constraints
#=
Given our constraint layout we can parition Inventory variables
into two groups, one representing the immediate use of previous surplus
and the other indicating our new surplus for the current month
=#
use = cat(0,I; dims =1 )
save = cat(I, 0; dims = 1)

cons = use .+ x .- save
cons

# Our contract specifications
b = [100, 250, 190, 140, 220, 110]

# compact all constraints into a single array (Cool, huh?)
@expression(model, con, cons)
@constraint(model, constraint,con .== b)

# optimize
optimize!(model)

# get minimum cost
obj = objective_value(model)
println("Objective Value:")
display(obj)
println("Optimal Window Variables:")
println(value.(x))
println("Optimal Inventory Variables:")
println(value.(x))
