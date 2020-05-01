# frozen_string_literal: true

# documentation comment
require_relative 'instance_counter'
require_relative 'validation'

# documentation comment
class Station
  include InstanceCounter
  include Validation

  @@all_stations = []

  def self.all
    @@all_stations
  end

  attr_reader :trains, :name

  validate :name, :doubling, :@@all_stations
  validate :name, :presence
  validate :name, :capitalize

  def initialize(name)
    @name = name
    validate!
    @@all_stations << self
    @trains = []
    register_instance
  end

  def arrive(train)
    @trains << train unless trains.include?(train)
  end

  def list_trains
    trains.each { |train| yield(train) }
  end

  def return_type(type)
    @trains.select { |train| train.type == type }
  end

  def delete(train)
    @trains.delete(train)
  end
end
