use aiken/math.{pow}

// checks that y is the smallest such that y^n >= x
// (y is integer approximation to x^(1/n))
pub fn is_nth_root(x, n, y) {
  pow(y, n) >= x && pow(y-1, n) < x
}
