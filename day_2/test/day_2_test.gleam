import day_2
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn part_1_example_test() {
  let assert Ok(file) = simplifile.read("example.txt")

  day_2.part_1(file)
  |> should.equal(2)
}

pub fn part_2_example_test() {
  let assert Ok(file) = simplifile.read("example.txt")

  day_2.part_2(file)
  |> should.equal(4)
}
