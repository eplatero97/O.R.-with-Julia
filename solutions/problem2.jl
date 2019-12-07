using JuMP
using Cbc

# init model
m = Model(with_optimizer(Cbc.Optimizer))

# define decision variables
@variable(m, x[i = 1:3] >= 0, base_name = "Decision Variables")

# define objective
profit = [24 22 45]
expr = sum(profit * x)
@expression(m, obj, expr)
@objective(m, Max, obj)

# define constraints
A = [2 1 3;
     2 1 2;
     1 .5 1]
b = [42, 40, 45] # vector shape
@constraint(m, con, A'x .<= b )

# optimize
optimize!(m)

println("Maximum Value:")
display(objective_value(m))
println("Decision Variables")
print(value.(x))
