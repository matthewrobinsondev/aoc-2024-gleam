import day_1
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  should.equal(11, day_1.handle_lists([3, 4, 2, 1, 3, 3], [4, 3, 5, 3, 9, 3]))
}
