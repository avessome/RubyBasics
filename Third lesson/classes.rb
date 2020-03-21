class Station

  def initialize(name)
    @name = name
    @trains = [ ]
  end

  def arrive(train)
    @trains << train unless trains.include?(train)
  end

  def train_type(type)
    @trains.select { |train| train.type == type}
  end

  def departure(train)
    @trains.delete(train)
  end
end

class Route

  def initialize(first, last)
    @stations = [first, last]
  end

  def add_station(station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def delete_station(station)
    retutn unless (@stations.first || @stations.last) != station
    @stations.delete(station)
  end

  def route_list
    @stations.each { |station| puts "#{station.name} #{station}" }
  end
end

class Train

  def initialize(number, type, wagons_quantity)
    @number = number
    @type = type
    @wagons_quantity = wagons_quantity
    @speed = 0
  end

  def speed_gain(value)
    @speed += value if value.positive?
  end

  def speed_reduction(value)
    @speed -= value if value <= @speed && value.positive?
  end

  def add_wagon
    @wagons_quantity += 1 if @speed.zero?
  end

  def delete_wagon
    @wagons_quantity -=1 if @speed.zero? && @wagons_quantity.positive?
  end

  def route(route)
    @route = route
    @current_station = @route.stations.first
    @current_station.arrive(self)
  end

  def move_forward
    return unless @current_station
    current_index = @route.stations.find_index(@current_station)
    return unless current_index + 1 < @route.stations.count
    @current_station.delete(self)
    @current_station = @route.stations[current_index + 1]
    @current_station.arrive(self)
  end

  def move_back
    return unless @current_station
    current_index = @route.stations.find_index(@current_station)
    return unless current_index - 1 >= 0
    @current_station.delete(self)
    @current_station = @route.stations[current_index - 1]
    @current_station.arrive(self)
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
