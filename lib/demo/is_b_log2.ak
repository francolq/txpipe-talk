use aiken/math.{pow}
use demo/is_nth_root.{is_nth_root}

pub fn is_b_log2(x: Int, b: Int, y: Int, r1: Int, r2: Int) {
  let e = pow(2, y)
  is_nth_root(e, b, r1) &&
    is_nth_root(e * 2, b, r2) &&
    r1 <= x && r2 > x
}

// test is_b_log2_1() {
//   // nth_root(pow(2, 15052), 1000) == 33971 &&
//   // nth_root(pow(2, 15052 + 1), 1000) == 33995
//   let h1 = 15052  // b_log2(33986, 1000)
//   let h2 = 33971  // nth_root(pow(2, h1), 1000)
//   let h3 = 33995  // nth_root(pow(2, h1 + 1), 1000)
//   is_b_log2(33986, 1000, h1, h2, h3)
// }

// test is_b_log2_2() {
//   // nth_root(pow(2, 15062), 1000) == 34207
//   // nth_root(pow(2, 15062 + 1), 1000) == 34231
//   let h1 = 15062  // b_log2(34217, 1000)
//   let h2 = 34207  // nth_root(pow(2, h1), 1000)
//   let h3 = 34231  // nth_root(pow(2, h1 + 1), 1000)
//   is_b_log2(34217, 1000, h1, h2, h3)
// }
