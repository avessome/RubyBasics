class PassengerWagon < Wagon
  def initialize(capacity)
    super 'pass', capacity
  end

  def take_seat
    return unless @capacity.positive?

    @capacity -= 1
    @occupied += 1
  end
end
