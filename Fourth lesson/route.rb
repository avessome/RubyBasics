class Route
  attr_reader :stations
  def initialize(first, last)
    @stations = [first, last]
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
