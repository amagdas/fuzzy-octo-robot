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
    large_input()
    |> prepare_input()
    |> Enum.filter(fn {[x1, y1], [x2, y2]} -> x1 == x2 || y1 == y2 end)
    |> Enum.map(&generate_pairs/1)
    |> Enum.concat()
    |> Enum.frequencies()
    |> Enum.reduce(0, fn {_key, val}, acc ->
      case val > 1 do
        true -> acc + 1
        _ -> acc
      end
    end)
  end

  def generate_pairs({[x1, y1], [x2, y2]}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
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
