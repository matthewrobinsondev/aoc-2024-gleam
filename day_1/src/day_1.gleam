import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile.{read}

pub fn main() {
  let assert Ok(contents) = read("input.txt")
  let rows = string.split(contents, on: "\n")

  let sorted_lists =
    list.fold(rows, #([], []), fn(acc, row) {
      let #(left, right) = acc
      case string.split(row, "   ") {
        [left_str, right_str] -> #(
          list.sort(
            list.append(left, [int.parse(left_str) |> result.unwrap(or: 0)]),
            by: int.compare,
          ),
          list.sort(
            list.append(right, [int.parse(right_str) |> result.unwrap(or: 0)]),
            by: int.compare,
          ),
        )
        _ -> #(left, right)
      }
    })

  handle_lists(sorted_lists.0, sorted_lists.1)
  handle_similarity_score(sorted_lists.0, sorted_lists.1)
}

pub fn handle_lists(a: List(Int), b: List(Int)) -> Int {
  list.zip(a, b)
  |> list.map(fn(pair) {
    let #(x, y) = pair
    int.absolute_value(x - y)
  })
  |> int.sum()
  |> io.debug
}

pub fn handle_similarity_score(a: List(Int), b: List(Int)) -> Int {
  list.fold(a, 0, fn(acc, element) {
    let matches = list.count(b, fn(x) { x == element })
    acc + int.multiply(element, matches)
  })
  |> io.debug
}
