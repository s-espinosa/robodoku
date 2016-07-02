class Spot
  attr_reader :value, :neighbors, :highest_number, :potential_values

  def initialize(value, neighbors, highest_number)
    @value = value
    @neighbors = neighbors
    @highest_number = highest_number
    @potential_values = potential_values
  end

  def potential_values
    possible_values =* (1..highest_number)
    @potential_vlaues = possible_values - @neighbors
  end

  def set_value
    @value = @potential_values[0] if @potential_values.length == 1
  end
end
