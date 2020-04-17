# frozen_string_literal: true

# documentation comment
class CargoWagon < Wagon
  def initialize(capacity)
    super 'cargo', capacity
  end

  def takes_volume(capacity)
    return unless capacity.positive? && capacity < @free_capacity

    @free_capacity -= capacity
  end
end
