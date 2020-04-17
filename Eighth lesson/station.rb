require_relative 'instance_counter'

class Station
  include InstanceCounter

  @@all_stations = []

  def self.all
    @@all_stations
  end

  attr_reader :trains, :name
  def initialize(name)
    @@all_stations << self
    @name = name
    validate!
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

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Ошибка! Отсутствует название станции.' if @name.nil? || @name.empty?
  end
end
