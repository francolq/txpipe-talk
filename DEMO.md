# Difficult math in Aiken

## A bit of context

* Compute on-chain for given integers $b, q_1, q_2$:

$$C(q_1, q_2) = b * \log_2(2^\frac{q_1}{b} + 2^\frac{q_2}{b})$$

* Work with big numbers and decimal digits
* At first it looked impossible
* Let's divide this problem in parts

## "Pow" with rational exponent

* Compute for two integers $q, b$:

$$2^\frac{q}{b}$$

* "Amplification":

$$2^n \times 2^\frac{q}{b} = 2^{\frac{n * b + q}{b}}$$


* Alternatives (using Aiken's `pow`):
1. `pow(2, `$\frac{n * b + q}{b}$`)`
2. `pow(`$2^\frac{1}{b}$`, n * b + q)`
3. `pow(2, n * b + q)`$^\frac{1}{b}$

Wich one is better?

## N-th root

* Compute for two integers:

$$x^\frac{1}{b}$$

* This is $y$ such that:

  $$y^b = x$$

* Example 1:

$$81^\frac{1}{4} = 3$$

* Example 2:

$$83^\frac{1}{4} = 3.0183494792...$$

* We will round up:

$$83^\frac{1}{4} \sim 4$$

### First solution: linear search

* Find smaller $y$ such that:

    $$y^b \geq x$$

* Start from $y = 0$ and increment in 1 until condition is met

* Example: $x = 83, b = 4$

  - $0^4 = 0$
  - $1^4 = 1$
  - $2^4 = 16$
  - $3^4 = 81$
  - $4^4 = 256$. Result: 4.

* Complexity: One `pow` per iteration ($y \log b$?)

* Problem: $x$ can be quite big!

* Let's try in Aiken

### Second solution: search better

* Find smaller $y$ such that:

    $$y^b \geq x$$

* Equivalently:
    $$y^b \geq x$$
  and  
    $$(y-1)^b < x$$

* Binary search (two steps):

  1. find a big $Y$ such that $y$ is in the interval $[0,Y]$
  2. search recursively dividing intervals in half

* Complexity: Two `pow` per iteration ($\log y \log b$?)

* Let's try it

### Third solution: don't search, ask and check

* Why search? The result can be provided in the tx

* Ask for the result and check:

    $$y^b \geq x$$
  and  
    $$(y-1)^b < x$$

* In Aiken:

  ```
  pub fn is_nth_root(x, b, y) {
    pow(y, b) >= x && pow(y-1, b) < x
  }
  ```

* Complexity: Always two `pow` to the $b$ ($\log b$)

* Let's try it


## Logarithm

* Compute:

$$y = b * \log_2(x)$$

* Solving for $x$:

$$x = 2^\frac{y}{b}$$

* Integer solution is $y$ such that:
  $$2^\frac{y}{b} \geq x$$
  and
  $$2^\frac{y+1}{b} < x$$

  (we are rounding down in this case)


### Solution: 

* Again: don't search, ask and check ($y$)

* Two nth-roots involved here!

  * For these two, also ask and check ($r1, r2$)

* In Aiken:
  ```
  pub fn is_b_log2(x: Int, b: Int, y: Int, r1: Int, r2: Int) {
    is_nth_root(pow(2, y), b, r1) &&
      is_nth_root(pow(2, y+1), b, r2) &&
      r1 <= x && r2 > x
  }
  ```

* With additional optimizations:
  ```
  pub fn is_b_log2(x: Int, b: Int, y: Int, r1: Int, r2: Int) {
    let e = pow(2, y)
    is_nth_root(e, b, r1) &&
      is_nth_root(e * 2, b, r2) &&
      r1 <= x && r2 > x
  }
  ```

## Conclusion

* 

* Whenever possible, don't compute, just check

* 

