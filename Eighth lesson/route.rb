# frozen_string_literal: true

# documentation comment
require_relative 'instance_counter'

# documentation comment
class Route
  include InstanceCounter
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
    register_instance
  end

  def midway(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def delete_midway(station)
    return unless (@stations.first || @stations.last) != station

    @stations.delete(station)
  end

  def list_stations
    @stations.each { |item| puts "#{item.name}, #{item}" }
  end
end
