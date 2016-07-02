require_relative './spot'
require_relative './puzzle'

class Solver
  attr_reader :puzzle, :working, :rows, :square_size

  def initialize(puzzle_text)
    @puzzle  = Puzzle.new(puzzle_text)
  end

  def solve
    until(@puzzle.working_values.flatten.detect{|i| i == " "} == nil) do
      set_values
      @puzzle = Puzzle.new(@puzzle.working_values)
    end
    format(@puzzle.working_values)
  end

  def set_values
    @puzzle.working.each do |row|
      row.each do |spot|
        spot.set_value
      end
    end
  end

  def format(working_array)
    working_array.each {|row| row << "\n" }
    working_array.flatten.join("")
  end
end
