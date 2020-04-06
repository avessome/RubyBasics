class CargoTrain < Train
  def initialize(name)
    super name, 'cargo'
  end
  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
