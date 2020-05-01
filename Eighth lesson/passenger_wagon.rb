# frozen_string_literal: true

# documentation comment
class PassengerWagon < Wagon
  strong_attr_accessor :carriage_class, Integer

  validate :capacity, :range

  def initialize(capacity)
    super 'pass', capacity
  end

  def take_seat
    return unless @capacity.positive?

    @free_capacity -= 1
  end
end
