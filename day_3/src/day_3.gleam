import gleam/int
import gleam/io
import gleam/list
import gleam/regex
import gleam/regexp
import gleam/result
import simplifile

pub fn main() {
  io.println("Hello from day_3!")
  let assert Ok(file) = simplifile.read("input.txt")
  part_one(file) |> io.debug
}

pub fn part_one(file: String) -> Int {
  let assert Ok(re) = regexp.from_string("mul\\((\\d{1,3}),\\s*(\\d{1,3})\\)")
  regexp.scan(re, file)
  |> list.fold(0, fn(acc, element) -> Int {
    let assert Ok(num) = regexp.from_string("\\d+")
    let score =
      regexp.scan(num, element.content)
      |> list.map(fn(element) { int.parse(element.content) |> result.unwrap(0) })
      |> int.product()
    let acc = acc + score
  })
}
