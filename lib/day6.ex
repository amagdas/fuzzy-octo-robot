defmodule AdventOfCode2021.Day6 do
  def part1() do
    input()
    |> advance_n_days(256)
  end

  def advance_n_days(fishes, n), do: advance_n_days(fishes, n + 1, 1)

  def advance_n_days(fishes, n, n), do: fishes

  def advance_n_days(fishes, n, current) do
    fishes =
      fishes
      |> Enum.reduce([], fn fish, acc ->
        case advance_fish(fish) do
          [old, offspring] -> [old, offspring] ++ acc
          old -> [old | acc]
        end
      end)

    advance_n_days(fishes, n, current + 1)
  end

  def advance_fish(0), do: [6, 8]
  def advance_fish(fish), do: fish - 1

  def input() do
    [3, 4, 3, 1, 2]
  end

  def large_input() do
    [
      2,
      5,
      5,
      3,
      2,
      2,
      5,
      1,
      4,
      5,
      2,
      1,
      5,
      5,
      1,
      2,
      3,
      3,
      4,
      1,
      4,
      1,
      4,
      4,
      2,
      1,
      5,
      5,
      3,
      5,
      4,
      3,
      4,
      1,
      5,
      4,
      1,
      5,
      5,
      5,
      4,
      3,
      1,
      2,
      1,
      5,
      1,
      4,
      4,
      1,
      4,
      1,
      3,
      1,
      1,
      1,
      3,
      1,
      1,
      2,
      1,
      3,
      1,
      1,
      1,
      2,
      3,
      5,
      5,
      3,
      2,
      3,
      3,
      2,
      2,
      1,
      3,
      1,
      3,
      1,
      5,
      5,
      1,
      2,
      3,
      2,
      1,
      1,
      2,
      1,
      2,
      1,
      2,
      2,
      1,
      3,
      5,
      4,
      3,
      3,
      2,
      2,
      3,
      1,
      4,
      2,
      2,
      1,
      3,
      4,
      5,
      4,
      2,
      5,
      4,
      1,
      2,
      1,
      3,
      5,
      3,
      3,
      5,
      4,
      1,
      1,
      5,
      2,
      4,
      4,
      1,
      2,
      2,
      5,
      5,
      3,
      1,
      2,
      4,
      3,
      3,
      1,
      4,
      2,
      5,
      1,
      5,
      1,
      2,
      1,
      1,
      1,
      1,
      3,
      5,
      5,
      1,
      5,
      5,
      1,
      2,
      2,
      1,
      2,
      1,
      2,
      1,
      2,
      1,
      4,
      5,
      1,
      2,
      4,
      3,
      3,
      3,
      1,
      5,
      3,
      2,
      2,
      1,
      4,
      2,
      4,
      2,
      3,
      2,
      5,
      1,
      5,
      1,
      1,
      1,
      3,
      1,
      1,
      3,
      5,
      4,
      2,
      5,
      3,
      2,
      2,
      1,
      4,
      5,
      1,
      3,
      2,
      5,
      1,
      2,
      1,
      4,
      1,
      5,
      5,
      1,
      2,
      2,
      1,
      2,
      4,
      5,
      3,
      3,
      1,
      4,
      4,
      3,
      1,
      4,
      2,
      4,
      4,
      3,
      4,
      1,
      4,
      5,
      3,
      1,
      4,
      2,
      2,
      3,
      4,
      4,
      4,
      1,
      4,
      3,
      1,
      3,
      4,
      5,
      1,
      5,
      4,
      4,
      4,
      5,
      5,
      5,
      2,
      1,
      3,
      4,
      3,
      2,
      5,
      3,
      1,
      3,
      2,
      2,
      3,
      1,
      4,
      5,
      3,
      5,
      5,
      3,
      2,
      3,
      1,
      2,
      5,
      2,
      1,
      3,
      1,
      1,
      1,
      5,
      1
    ]
  end
end
