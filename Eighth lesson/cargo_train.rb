# frozen_string_literal: true

# documentation comment
class CargoTrain < Train
  validate :name, :type, String
  validate :name, :presence
  validate :name, :format, /^[a-z\d]{3}-*[a-z\d]{2}$/i

  def initialize(name)
    super name, 'cargo'
  end

  def attach_wagon(wagon)
    super if @type == wagon.type
  end
end
