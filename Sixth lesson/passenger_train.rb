class PassengerTrain < Train
  def initialize(name)
    super name, 'pass'
  end

  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
