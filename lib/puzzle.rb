require_relative './spot'

class Puzzle
  attr_reader :raw_puzzle, :working, :rows, :square_size

  def initialize(puzzle_text)
    @raw_puzzle  = parse(puzzle_text)
    @rows        = @raw_puzzle.count
    @square_size = square_size
    @working     = create_working(@raw_puzzle)
  end

  def parse(puzzle_text)
    if puzzle_text.class == String
      puzzle = parse_string(puzzle_text)
    else
      puzzle = puzzle_text
    end
    @raw_puzzle = check_lines(puzzle)
  end

  def parse_string(puzzle_text)
    puzzle = []

    puzzle_text.each_line do |line|
      row = line.split('')[0..-2]
      puzzle << row
    end

    puzzle
  end

  def check_lines(puzzle)
    rows = puzzle.count
    puzzle.map do |line|
      missing = rows - line.length
      missing.times { line << " " }
      line
    end
  end

  def square_size
    if @rows == 2
      1
    else
      Math.sqrt(@rows).to_i
    end
  end

  def create_working(puzzle)
    working = puzzle.map.with_index do |row, row_index|
      row.map.with_index do |digit, column_index|
        Spot.new(digit, neighbors(row_index, column_index), @rows)
      end
    end
  end

  def neighbors(row, column)
    row_neighbors    = row_neighbors(row, column)
    column_neighbors = column_neighbors(row, column)
    square_neighbors = square_neighbors(row, column)
    all_neighbors    = row_neighbors | column_neighbors | square_neighbors
    all_neighbors.map {|digit| digit.to_i }.sort
  end

  def row_neighbors(row, column)
    value = @raw_puzzle[row][column]
    @raw_puzzle[row].reject{|a| a == value || a == " "}
  end

  def column_neighbors(row, column)
    value = @raw_puzzle[row][column]
    all = in_column(column)
    all.reject{|a| a == value || a == " "}
  end

  def square_neighbors(row, column)
    value = @raw_puzzle[row][column]
    in_square(row, column).reject{|a| a == value || a == " "}
  end

  def in_column(column)
    @raw_puzzle.map do |row|
      row[column]
    end
  end

  def in_square(row, column)
    in_square = []
    row_start        = row / square_size * square_size
    column_start     = column / square_size * square_size

    square_size.times do |i|
      square_size.times do |j|
        in_square << @raw_puzzle[row_start + i][column_start + j]
      end
    end
    in_square
  end

  def working_values
    working.map do |row|
      row.map do |spot|
        spot.value
      end
    end
  end
end
