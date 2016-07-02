require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/solver"

class SolverTest < Minitest::Test
  attr_reader :solver, :medium_solver

  def setup
    puzzle_text = File.read('puzzles/two_by_two_trivial.txt')
    @solver = Solver.new(puzzle_text)
    medium_puzzle_text = File.read('puzzles/four_by_four_trivial.txt')
    @medium_solver = Solver.new(medium_puzzle_text)
  end

  def test_it_accepts_a_puzzle_as_an_argument
    assert(solver.class == Solver)
  end

  def test_it_stores_the_puzzle_as_an_array_of_arrays
    assert(solver.puzzle == [[" ", "2"], ["2", "1"]])
  end

  def test_it_has_a_working_array
    assert(solver.working[0][0].class == Spot)
  end

  def test_it_knows_how_many_rows_the_puzzle_has
    assert(solver.rows == 2)
  end

  def test_it_knows_its_square_size
    assert(solver.square_size == 1)
  end

  def test_it_knows_its_square_size_for_larger_squares
    assert(medium_solver.rows == 4)
    assert(medium_solver.square_size == 2)
  end

  def test_it_can_find_row_neighbors
    assert(medium_solver.row_neighbors(0, 0) == ["2", "4", "1"])
    assert(medium_solver.row_neighbors(2, 1) == ["1", "2", "3"])
  end

  def test_it_can_find_column_neighbors
    assert(medium_solver.column_neighbors(0, 0) == ["4", "1", "2"])
    assert(medium_solver.column_neighbors(1, 2) == ["4", "2"])
  end

  def test_it_can_find_all_values_in_a_column
    assert(medium_solver.in_column(0) == ["3", "4", "1", "2"])
  end

  def test_it_can_find_all_values_in_a_square
    assert(medium_solver.in_square(0, 2) == ["4", "1", "3", "2"])
    assert(medium_solver.in_square(3, 2) == ["2", "3", " ", "4"])
  end

  def test_it_can_find_square_neighbors
    assert(medium_solver.square_neighbors(2, 2) == ["3", "4"])
    assert(medium_solver.square_neighbors(0, 1) == ["3", "4", "1"])
  end

  def test_it_can_find_neighbors
    assert(medium_solver.neighbors(3, 2) == [2, 3, 4])
    assert(medium_solver.neighbors(3, 1) == [1, 2, 4])
    assert(medium_solver.neighbors(0, 0) == [1, 2, 4])
  end

  def test_it_can_return_working_values
    assert(solver.working_values == [[" ", "2"], ["2", "1"]])
  end

  def test_it_can_solve_a_trivial_puzzle
    assert(solver.solve == "12\n21\n")
  end
end
