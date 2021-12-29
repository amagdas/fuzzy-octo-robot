defmodule AdventOfCode2021.Day5 do
  def prepare_input(lines) do
    pair_parser = fn pair ->
      pair
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end

    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " -> ", trim: true))
    |> Enum.map(fn [pair1, pair2] ->
      {pair_parser.(pair1), pair_parser.(pair2)}
    end)
  end

  def part1() do
    input()
    |> prepare_input()
    |> generate_lines()
    |> calculate_intersections()
  end

  def part2() do
    lines =
      large_input()
      |> prepare_input()

    line_pairs = lines |> generate_lines()

    diagonal_pairs = lines |> generate_diagonals()

    (line_pairs ++ diagonal_pairs)
    |> calculate_intersections()
  end

  def calculate_intersections(lines) do
    lines
    |> Enum.concat()
    |> Enum.frequencies()
    |> Enum.reduce(0, fn {_key, val}, acc ->
      case val > 1 do
        true -> acc + 1
        _ -> acc
      end
    end)
  end

  def generate_lines(lines) do
    lines
    |> Enum.filter(fn {[x1, y1], [x2, y2]} -> x1 == x2 || y1 == y2 end)
    |> Enum.map(&generate_line_pairs/1)
  end

  def generate_diagonals(lines) do
    lines
    |> Enum.filter(fn {[x1, y1], [x2, y2]} ->
      abs(x1 - x2) == abs(y1 - y2)
    end)
    |> Enum.map(&generate_diagonal_pairs/1)
  end

  def generate_line_pairs({[x1, y1], [x2, y2]}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end

  def generate_diagonal_pairs({[x1, y1], [x2, y2]}) do
    xs = x1..x2 |> Enum.to_list()
    ys = y1..y2 |> Enum.to_list()
    Enum.zip(xs, ys)
  end

  def input() do
    """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """
  end

  def large_input() do
    File.read("./inputs/day5.txt")
    |> then(&elem(&1, 1))
  end
end
