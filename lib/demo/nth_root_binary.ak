use aiken/math.{pow}

// smallest y such that y^n >= x
// (integer approximation to x^(1/n))
// version with binary search
pub fn nth_root(x: Int, n: Int) {
  nth_root_gen2(x, n, 1)
}

// auxiliary for nth_root with binary search
fn nth_root_gen2(x: Int, n: Int, y: Int) {
  if pow(y, n) >= x {
    // answer is between y / 2 and y
    nth_root_gen3(x, n, y / 2, y)
  } else {
    nth_root_gen2(x, n, 2 * y)
  }
}

// auxiliary for nth_root with binary search
fn nth_root_gen3(x: Int, n: Int, y1: Int, y2: Int) {
  let mid = (y1 + y2) / 2
  if pow(mid, n) >= x {
    if pow(mid-1, n) < x {
      mid
    } else {
      nth_root_gen3(x, n, y1, mid - 1)
    }
  } else {
    nth_root_gen3(x, n, mid + 1, y2)
  }
}
