# frozen_string_literal: true

# documentation comment
require_relative 'instance_counter'
require_relative 'module_company'
require_relative 'module_accessors'
require_relative 'validation'

# documentation comment
class Train
  include Accessor
  include Company
  include InstanceCounter
  include Validation

  @@trains = {}

  def self.find(name)
    @@trains[name]
  end

  attr_reader :name, :type, :wagons, :current_station, :current_speed

  validate :name, :type, String
  validate :name, :presence
  validate :name, :format, /^[a-z\d]{3}-*[a-z\d]{2}$/i

  strong_attr_accessor :engine_type, String

  def initialize(name, type)
    @name = name.to_s
    @type = type
    validate!

    @wagons = []
    @current_speed = 0
    @@trains[name] = self
    register_instance
  end

  def list_wagons
    wagons.each_with_index { |wagon, index| yield(wagon, index) }
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
end
