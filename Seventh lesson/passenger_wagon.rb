class PassengerWagon < Wagon
  def initialize(capacity)
    super 'pass', capacity
  end

  def take_seat
    return unless @capacity.positive?

    @occupied += 1
  end
end
