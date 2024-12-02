import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(file) = simplifile.read("input.txt")
  part_1(file) |> io.debug
  part_2(file) |> io.debug
}

pub fn part_1(file: String) {
  string.trim(file)
  |> string.split("\n")
  |> list.fold(0, fn(acc, row) {
    let levels =
      string.split(row, " ")
      |> list.filter(fn(element) { !string.is_empty(element) })
      |> list.map(fn(level) { int.parse(level) |> result.unwrap(or: 0) })

    acc + bool.to_int(validate_row(levels))
  })
}

pub fn part_2(file: String) {
  string.trim(file)
  |> string.split("\n")
  |> list.fold(0, fn(acc, row) {
    let levels =
      string.split(row, " ")
      |> list.filter(fn(element) { !string.is_empty(element) })
      |> list.map(fn(level) { int.parse(level) |> result.unwrap(or: 0) })

    acc
    + case bool.to_int(validate_row(levels)) {
      1 -> 1
      0 -> bool.to_int(validate_with_fault(levels))
      _ -> 0
    }
  })
}

fn validate_with_fault(levels) {
  list.index_map(levels, fn(_, index) {
    let #(left, right) = list.split(levels, index)
    list.append(left, list.drop(right, 1))
  })
  |> list.any(fn(level) { validate_row(level) })
}

fn validate_row(levels: List(Int)) -> Bool {
  let first_two_elements = list.split(levels, 2)
  let defined_order =
    int.compare(
      list.first(first_two_elements.0) |> result.unwrap(0),
      list.last(first_two_elements.1) |> result.unwrap(0),
    )

  let toupled_values =
    list.window_by_2(levels)
    |> list.map(fn(level) {
      let #(left, right) = level
      left - right
    })

  let in_order = case toupled_values {
    [] -> False
    _ ->
      list.all(toupled_values, fn(element) {
        case defined_order {
          order.Lt -> element < 0
          order.Gt -> element > 0
          order.Eq -> False
        }
      })
  }

  let in_range = case toupled_values {
    [] -> False
    _ ->
      list.all(toupled_values, fn(element) { int.absolute_value(element) <= 3 })
  }

  in_order && in_range
}
