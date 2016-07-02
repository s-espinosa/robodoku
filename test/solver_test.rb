require "minitest"
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/solver"

class SolverTest < Minitest::Test
  def test_it_can_solve_a_trivial_puzzle
    puzzle_text = File.read('puzzles/two_by_two_trivial.txt')
    solver      = Solver.new(puzzle_text)
    
    assert(solver.solve == "12\n21\n")
  end
end
