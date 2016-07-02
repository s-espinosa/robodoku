require_relative './spot'

class Solver
  attr_reader :puzzle, :working, :columns, :square_size

  def initialize(puzzle_text)
    @puzzle  = parse(puzzle_text)
    @columns = @puzzle[0].count
    @square_size = square_size
    @working = create_working(@puzzle)
  end

  def parse(puzzle_text)
    puzzle = []
    puzzle_text.each_line do |line|
      row = line.split('')[0..-2]
      puzzle << row
    end
    @puzzle = puzzle
  end

  def create_working(puzzle)
    working = puzzle.map do |row|
      row.map.with_index do |digit, index|
        Spot.new(digit, [], @columns)
        #Spot.new(digit, neighbors(row, index), @columns)
      end
    end
  end

  def neighbors(row, column)
    row_neighbors = find_row_neighbors(row, column)
    column_neighbors = find_column_neighbors(row, column)
    square_neighbors = find_square_neighbors(row, column)
  end

  def square_size
    if @columns == 2
      1
    else
      Math.sqrt(@columns).to_i
    end
  end

  def row_neighbors(row, column)
    value = @puzzle[row][column]
    @puzzle[row].reject{|a| a == value || a == " "}
  end

  def column_neighbors(row, column)
    value = @puzzle[row][column]
    all = in_column(column)
    all.reject{|a| a == value || a == " "}
  end

  def in_column(column)
    @puzzle.map do |row|
      row[column]
    end
  end

  def in_square(row, column)
    in_square = []
    row_start        = row / square_size * square_size
    column_start     = column / square_size * square_size

    square_size.times do |i|
      square_size.times do |j|
        in_square << @puzzle[row_start + i][column_start + j]
      end
    end
    in_square
  end
end
