use aiken/math.{pow}

// smallest y such that y^n >= x
// (integer approximation to x^(1/n))
// version with linear search
pub fn nth_root(x: Int, n: Int) {
  nth_root_gen(x, n, 0)
}

// auxiliary for nth_root with linear search
fn nth_root_gen(x: Int, n: Int, y: Int) {
  if pow(y, n) >= x {
    y
  } else {
    nth_root_gen(x, n, y+1)
  }
}
