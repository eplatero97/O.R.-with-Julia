# Daily O.R. Problem using Julia

Julia is a fast, intuitive, and a dynamic programming language, which makes it extremely adept for an O.R. domain.

Each problem will be solved using JuMP, a mathematical modeling language for optimization (Version 0.20.0).

---

#### Problem 1

Acme Manufacturing Company has a contract to deliver 100, 250, 190, 140, 220, and 110 home
windows over the next 6 months. Production cost (labor, material, and utilities) per window
varies by period and is estimated to be 50, 45, 55, 48, 52, and 50 over the next 6 months.
To take advantage of the fluctuations in manufacturing cost, Acme can produce more windows
than needed in a given month and hold the extra units for delivery in later months. This will
incur a storage cost at the rate of $8 per window per month, assessed on end-of-month inventory.
Develop a linear program to determine the optimum production schedule (Taha, pg. 64-65).

[Solution](https://github.com/Erick7451/O.R.-with-Julia/blob/master/solutions/problem1.jl)

---

#### Problem 2

In preparation for the winter season, a clothing company is manufacturing parka and goose
overcoats, insulated pants, and gloves. All products are manufactured in four different departments: cutting, insulating, sewing, and packaging. The company has received firm orders for its products. The contract stipulates a penalty for undelivered items. Devise an **optimal production plan** for the company based on the following data:
(Taha, pg. 62-63)
![problem2](https://github.com/Erick7451/O.R.-with-Julia/blob/master/images/problem2.PNG)

[Solution](https://github.com/Erick7451/O.R.-with-Julia/blob/master/solutions/problem2.jl)

---

#### Problem 3

The Gutchi Company manufactures purses, shaving bags, and backpacks. The construction
includes leather and synthetics, leather being the scarce raw material. The production process
requires two types of skilled labor: sewing and finishing. The following table gives the
availability of the resources, their usage by the three products, and the profits per unit.

![gutchi](https://github.com/Erick7451/O.R.-with-Julia/blob/master/images/gutchi.PNG)

(a) Formulate the problem as a linear program, and find the optimum solution (using
TORA, Excel Solver, or AMPL).
(b) From the optimum solution, determine the status of each resource (Taha, pg. 152).

[Solution](https://github.com/Erick7451/O.R.-with-Julia/blob/master/solutions/problem3.jl)

---

#### Problem 4

Solve below ZudokuX 

![SudokuX](https://github.com/Erick7451/O.R.-with-Julia/blob/master/images/SudokuX.png)

[Solution](https://github.com/Erick7451/O.R.-with-Julia/blob/master/solutions/sudokuX.jl)



---

### References

Taha, H. A. (2017) *Operations Research An Introduction* [Tenth Edition]
