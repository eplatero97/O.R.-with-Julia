using JuMP, Cbc

# Initialize Sudoku Model with JuMP Properties
sudoku = Model(with_optimizer(Cbc.Optimizer))

# objective is constant as we are ONLY trying to reach a feasible solution
@objective(sudoku,Min,0)

# Create all 729 Variables. Function automatically creates cartesian product of all possibilities
@variable(sudoku, x[i=1:9,j=1:9, k=1:9], Bin) #Bin == Binary
# x_{i,j,k} \in {0,1} \for i,j,k \in {1:9}

# assert sum of cell per k values == 1
for i = 1:9, j = 1:9
    @constraint(sudoku, sum(x[i,j,k] for k in 1:9) == 1)
end

# add consraint where sum(per row/col) == 1
for ind = 1:9  # row or digit
    for k = 1:9  # Each digit
        # Sum across columns (j)
        @constraint(sudoku, sum(x[ind,j,k] for j=1:9) == 1)
        # Sum across rows (i)
        @constraint(sudoku, sum(x[i,ind,k] for i=1:9) == 1)
    end
end

# add constraint where sub-matrices sum == 1
for p in 1:3, q in 1:3, k in 1:9
	@constraint(sudoku, sum(x[i,j,k] for i in 3q-2:3q, j in 3p-2:3p) == 1)
end

# upper left diagonal constraint
for k in 1:9
	@constraint(sudoku,sum(x[ind,ind,k] for ind in 1:9) == 1)
end

# upper right diagonal constraint
for k in 1:9
	@constraint(sudoku,sum(x[c[1],c[2],k] for c in zip(1:9,9:-1:1)) == 1)
end




# Initial Sudoku Board
init_sol = [0 8 0 0 0 0 2 1 0;
			0 0 0 2 8 0 0 0 7;
			0 0 0 0 5 3 9 0 0;
			6 0 0 0 9 0 0 0 0;
			0 4 9 0 1 6 7 0 0;
			8 0 3 0 0 0 0 5 0;
			4 6 2 0 0 0 0 0 0;
			9 0 0 0 0 2 0 0 6;
			0 0 0 0 4 0 1 0 2]
println("Initial Soduko Problem:")
display(init_sol)
println()

# interpret each non-zero value in "init_sol" as a @constraint
for i = 1:9, j = 1:9
    # If cell is NOT empty
    if init_sol[i,j] != 0
        # make it a constraint
        @constraint(sudoku, x[i,j,init_sol[i,j]] == 1)
    end
end

# Solve
optimize!(sudoku)



# Extract the values of x. They come in a 3-dimensional matrix
x_val = value.(x)
# instantiate empty matrix to fill in answers
sol = zeros(Int,9,9)
for i in 1:9, j in 1:9, k in 1:9
    # When adding the diagonal constraints, if the values became fractions
	# then we round to nearest integer. In Julia,
	# we add a little bias to round as round(Int,.5) == 0, we want == 1
    if round(Int, x_val[i,j,k] + .000001) == 1
        sol[i,j] = k
    end
end

# Display the solution
println()
println("Solution:")
display(sol)


#=
Assert solution satisfies the
sum of rows,cols, diagonals and sub-matrices == 45 in check() function
=#

function check(sol)
dim = size(sol)[1] # grab rows

# sum of 1:9
expected = sum(1:dim)

if sum(sum(sol,dims=1) .== expected) == dim
	# if sum per rows == 49 for 9 cols
	if sum(sum(sol,dims=2) .== expected) == dim
		# if sum of all 9 sub-matrices == 49
		subs = []
		for p in 1:3, q in 1:3
			val = sum(sol[i,j] for i in 3p-2:3p,  j in 3q-2:3q)
			append!(subs,val)
		end
		if sum(subs .== expected) == 9
			println("Row, column, and sub-matrix constraints have been met")
		end
	end


		subs = []
		for p in 1:3, q in 1:3

			val = sum(sol[i,j] for i in 3p-2:3p, j in 3q-2:3q)
			append!(subs,val)
		end
end

end

# ensure that rows, cols, and submatrices == 45
check(sol)

### ensure upper-left and upper-right diagonals == 45 ###

# upper left diagonal
upper_diag = [sol[ind,ind] for ind in 1:9]
sum(upper_diag) == 45


# upper right diagonal
diag = [sol[ind,ind] for ind in 9:-1:1]
sum(diag) == 45

println("If this prints, all constraints have been satisfied for diagonalX")
