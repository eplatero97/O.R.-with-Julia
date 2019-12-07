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

**Unique Properties:**

* Contract must be satisfied
* Problem is sequential
* FIFO ("First-In First-Out")

[Solution]()

---

#### Problem 2

The Gutchi Company manufactures purses, shaving bags, and backpacks. The construction
includes leather and synthetics, leather being the scarce raw material. The production process
requires two types of skilled labor: sewing and finishing. The following table gives the
availability of the resources, their usage by the three products, and the profits per unit.

![gutchi](C:\Users\erick\Documents\Github\O.R. with Julia\images\gutchi.PNG)

(a) Formulate the problem as a linear program, and find the optimum solution (using
TORA, Excel Solver, or AMPL).
(b) From the optimum solution, determine the status of each resource (Taha, pg. 152).

[Solution]()

---

#### Problem 3

Solve below ZudokuX 

![SudokuX](C:\Users\erick\Documents\Github\O.R. with Julia\images\SudokuX.png)

[Solution]()



---

### References

Taha, H. A. (2017) *Operations Research An Introduction* [Tenth Edition]