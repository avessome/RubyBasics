class PassengerWagon < Wagon
  def initialize(capacity)
    super 'pass', capacity
  end

  def take_seat
    return unless @capacity.positive?

    @free_capacity -= 1
  end
end
