# Modeling and problem solving with stochastic programming

## Mathematical Programming

The first case of mathematical programming is **Linear Programming** (LP). In LP all the variables are positive real number and all LP problem are P while in general Mixed Integere Linear Programming (MILP) are NP-Hard.


### Production Problem

$x_A ,x_W$ = liters of paint A/W produced

Max   $20*x_A+30*x_W$

s.t.   
$$x_A \leq60$$
$$x_W\leq50$$
$$1*x_A+2*x_W\leq120$$

$$x_A,x_W\geq0$$

### Knapsack problem

$x_1,x_2,x_2,x_3,x_4,x_5=$ 1 if the relic is taken 0 else

Max $100x_1+300x_2+60X_3+600x_4+450x_5$

s.t.
$$13x_1+6x_2+9x_3+24x_4+6x_5\leq30$$

## Decision-making under uncertainty

In most of the case the problems we deal with have uncertain parameter or data may become known during the decision making process. We must remember that our deterministic model are an approximation of the problems they are trying to solve. There are 2 possible types of uncertainty:

- Exogenous: decisions are not able to influence the stochastic process
- Endogenous: decisions influence the stochastic process

How can  we represent the random outcomes? Do we know something about a process (probability distributions, historical data, bounds etc.).

### Newsvendor problem

How can we minimize/maximize a function with a uncertain variable?

$x_P,x_B,x_R=$ number of newspaper of type P,B,R ordered $D_P,D_B$ demand of politican and business newspaper
Objective function : $$Max(1.30x_P+1.20x_B+1.00x_R)$$

s.t
$$x_P\leq D_P$$
$$x_B\leq100-D_P$$
$$x_P+x_B+x_R\leq1000$$
$$x_P,x_B,x_R\geq0$$
$$x_P,x_B,x_R\in \N$$

but $D_P$ is the ratio of demand for political newspaper so I can modify my constraint that becomes

$$x_P\leq D_P$$
$$x_P\leq1-D_P$$
$$x_P+x_B+x_R\leq1$$
$$x_P,x_B,x_R\geq0 ,\in \Z+$$

$D_P$ is the **uncertain** ratio of demand of **P**olitical newspaper

The first approach would be to use the expected value. but doing this it may occur that if the optimal solutions depends on that stochastic parameters the the solution could be sub-optimal or even non-feasible.

