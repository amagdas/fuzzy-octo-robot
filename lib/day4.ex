defmodule AdventOfCode2021.Day4 do
  defmodule Board do
    @enforce_keys [:values, :dimensions, :index]
    defstruct values: [], dimensions: [], index: 0

    defmodule BingoDimension do
      @enforce_keys [:set]
      defstruct set: nil

      def new(values) do
        %__MODULE__{set: MapSet.new(values)}
      end

      def bingo?(%__MODULE__{set: dimension_set}, input) do
        MapSet.subset?(dimension_set, input)
      end
    end

    def new({lines, index}) do
      rows = lines |> Enum.map(&Board.BingoDimension.new(&1))
      columns = lines |> Enum.zip() |> Enum.map(&Board.BingoDimension.new(Tuple.to_list(&1)))

      %__MODULE__{values: Enum.concat(lines), dimensions: rows ++ columns, index: index}
    end

    def bingo?(board, input) do
      board.dimensions |> Enum.find(&Board.BingoDimension.bingo?(&1, input))
    end

    def score(board, input, winning_number) do
      sum_unmarked =
        board.values
        |> Enum.reduce(0, fn number, acc ->
          case MapSet.member?(input, number) do
            true -> acc
            false -> acc + number
          end
        end)
        |> IO.inspect(label: "unmarked")

      winning_number * sum_unmarked
    end
  end

  def part1() do
    {bingo_input, boards} =
      large_input()
      |> prepare_input()
      |> IO.inspect(label: "bingo")

    bingo_input
    |> Enum.reduce_while(MapSet.new(), fn number, acc ->
      acc = MapSet.put(acc, number)

      case Enum.find(boards, &Board.bingo?(&1, acc)) do
        nil ->
          {:cont, acc}

        board ->
          {board, number, acc}
          |> IO.inspect(label: "winning board")

          {:halt, {number, Board.score(board, acc, number)}}
      end
    end)
  end

  def part2() do
    {bingo_input, boards} =
      input()
      |> prepare_input()
      |> IO.inspect(label: "bingo")

    {_bingo_numbers, completed, _remaining_boards, last_winning_combination} =
      bingo_input
      |> Enum.reduce(
        {MapSet.new(), [], boards, nil},
        fn number, {bingo_numbers, completed, remaining_boards, last_winning} ->
          bingo_numbers = MapSet.put(bingo_numbers, number)

          case Enum.split_with(remaining_boards, &Board.bingo?(&1, bingo_numbers)) do
            {[], remaining} ->
              {bingo_numbers, completed, remaining, last_winning}

            {new_completed, remaining} ->
              {bingo_numbers, new_completed, remaining, {bingo_numbers, number}}
          end
        end
      )

    {last_bingo, number} = last_winning_combination
    last_completed_board = completed |> Enum.reverse() |> hd()
    Board.score(last_completed_board, last_bingo, number)
  end

  def prepare_input(lines) do
    [bingo_numbers | board_lines] =
      lines
      |> String.split("\n", trim: true)

    bingo_input =
      bingo_numbers
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer(&1))

    boards =
      board_lines
      |> Enum.chunk_every(5)
      |> Enum.map(fn lines ->
        lines
        |> Enum.map(fn line ->
          line
          |> String.split(" ", trim: true)
          |> Enum.map(&String.to_integer(&1))
        end)
      end)
      |> Enum.with_index()
      |> Enum.map(&Board.new(&1))

    {bingo_input, boards}
  end

  def input() do
    """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
    8  2 23  4 24
    21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19

    3 15  0  2 22
    9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
    2  0 12  3  7
    """
  end

  def large_input() do
    File.read("./inputs/day4.txt")
    |> then(&elem(&1, 1))
  end
end
