require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/spot'

class SpotTest < Minitest::Test
  def test_it_has_a_value
    spot = Spot.new(1, [1, 3, 5], 5)

    assert(spot.class == Spot)
    assert(spot.value == 1)
  end

  def test_it_has_neighbors
    spot = Spot.new(1, [1, 3, 5], 5)

    assert(spot.neighbors == [1, 3, 5])
  end

  def test_it_has_a_highest_number
    spot = Spot.new(1, [1, 3, 5], 5)

    assert(spot.highest_number == 5)
  end

  def test_it_has_potential_values
    spot = Spot.new(" ", [1, 3, 5], 5)

    assert(spot.potential_values == [2, 4])
  end

  def test_it_can_set_its_value
    spot = Spot.new(" ", [1, 2, 3, 5], 5)
    spot.set_value

    assert(spot.value == "4")
  end

  def test_it_does_not_set_its_value_when_options_exist
    spot = Spot.new(" ", [1, 3, 5], 5)
    spot.set_value

    assert(spot.value == " ")
  end
end
