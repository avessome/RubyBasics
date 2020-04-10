class CargoWagon < Wagon
  def initialize(capacity)
    super 'cargo', capacity
  end

  def takes_volume(capacity)
    return if capacity <= 0 || capacity > @capacity
    
    @occupied += capacity
  end
end
