import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile.{read}

pub fn main() {
  let assert Ok(contents) = read("example.txt")
  let rows = string.split(contents, on: "\n")

  let lists =
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

  io.debug(lists)
}

pub fn handle_lists(a: List(Int), b: List(Int)) -> Int {
  todo
}
