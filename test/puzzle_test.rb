require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/puzzle"

class PuzzleTest < Minitest::Test
  attr_reader :puzzle, :medium_puzzle

  def setup
    puzzle_text        = File.read('puzzles/two_by_two_trivial.txt')
    @puzzle            = Puzzle.new(puzzle_text)
    medium_puzzle_text = File.read('puzzles/four_by_four_trivial.txt')
    @medium_puzzle     = Puzzle.new(medium_puzzle_text)
  end

  def test_it_accepts_a_puzzle_as_an_argument
    assert(puzzle.class == Puzzle)
  end

  def test_it_stores_the_puzzle_as_an_array_of_arrays
    assert(puzzle.raw_puzzle == [[" ", "2"], ["2", "1"]])
  end

  def test_it_has_a_working_array
    assert(puzzle.working[0][0].class == Spot)
  end

  def test_it_knows_how_many_rows_the_puzzle_has
    assert(puzzle.rows == 2)
  end

  def test_it_knows_its_square_size
    assert(puzzle.square_size == 1)
  end

  def test_it_knows_its_square_size_for_larger_squares
    assert(medium_puzzle.rows == 4)
    assert(medium_puzzle.square_size == 2)
  end

  def test_it_can_find_row_neighbors
    assert(medium_puzzle.row_neighbors(0, 0) == ["2", "4", "1"])
    assert(medium_puzzle.row_neighbors(2, 1) == ["1", "2", "3"])
  end

  def test_it_can_find_column_neighbors
    assert(medium_puzzle.column_neighbors(0, 0) == ["4", "1", "2"])
    assert(medium_puzzle.column_neighbors(1, 2) == ["4", "2"])
  end

  def test_it_can_find_all_values_in_a_column
    assert(medium_puzzle.in_column(0) == ["3", "4", "1", "2"])
  end

  def test_it_can_find_all_values_in_a_square
    assert(medium_puzzle.in_square(0, 2) == ["4", "1", "3", "2"])
    assert(medium_puzzle.in_square(3, 2) == ["2", "3", " ", "4"])
  end

  def test_it_can_find_square_neighbors
    assert(medium_puzzle.square_neighbors(2, 2) == ["3", "4"])
    assert(medium_puzzle.square_neighbors(0, 1) == ["3", "4", "1"])
  end

  def test_it_can_find_neighbors
    assert(medium_puzzle.neighbors(3, 2) == [2, 3, 4])
    assert(medium_puzzle.neighbors(3, 1) == [1, 2, 4])
    assert(medium_puzzle.neighbors(0, 0) == [1, 2, 4])
  end

  def test_it_can_return_working_values
    assert(puzzle.working_values == [[" ", "2"], ["2", "1"]])
  end
end
