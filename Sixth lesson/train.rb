require_relative 'module_company'
require_relative 'instance_counter'

class Train
  include Company
  include InstanceCounter

  NUMBER_FORMAT = /^[a-z\d]{3}-*[a-z\d]{2}$/i
  @@trains = {}

  def self.find(name)
    @@trains[name]
  end

  attr_reader :name, :type, :wagons, :current_station, :current_speed
  def initialize(name, type)
    @@trains[name] = self
    @name = name.to_s
    validate!
    @type = type
    @wagons = []
    @current_speed = 0
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def attach_wagon(wagon)
    return if @wagons.include? wagon
    @wagons << wagon if @current_speed.zero?
  end

  def detach_wagon
    @wagons.pop if @current_speed.zero?
  end

  def route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.arrive(self)
  end

  def move_forwards
    return unless @current_station

    current_index = @route.stations.find_index(@current_station)

    return unless current_index + 1 < @route.stations.count

    @current_station.delete(self)

    @current_station = @route.stations[current_index + 1]
    @current_station.arrive(self)
  end

  def move_backwards
    return unless @current_station

    current_index = @route.stations.find_index(@current_station)

    return unless current_index - 1 >= 0

    @current_station.delete(self)

    @current_station = @route.stations[current_index - 1]
    @current_station.arrive(self)
  end

  protected

  def accelerate(value)
    @current_speed += value if value.positive?
  end

  def decelerate(value)
    @current_speed -= value if value <= @current_speed && value.positive?
  end

  def next_station
    return unless @current_station

    current_index = @route.stations.find_index(@current_station)

    return unless @current_station != @route.stations.last

    @route.stations[current_index + 1]
  end

  def previous_station
    return unless @current_station

    current_index = @route.stations.find_index(@current_station)

    return unless @current_station != @route.stations.first

    @route.stations[current_index - 1]
  end

  private

  def validate!
    raise 'Ошибка! Не правильный формат номера!' if name !~ NUMBER_FORMAT
  end
end
