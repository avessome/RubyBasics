class PassengerTrain < Train
  def initialize(number)
    super number, 'pass'
  end

  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
