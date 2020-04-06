class Railway
  attr_reader :routes, :trains, :wagons, :stations
  def initialize
    @routes = []
    @trains = []
    @wagons = []
    @stations = []
  end

  def menu_items
    messages = ['Выберите действие, введя номер из списка: ',
                BORDERLINE,
                ' 1 - Создать станцию.',
                ' 2 - Создать пассажирский поезд.',
                ' 3 - Создать грузовой поезд.',
                ' 4 - Создать пассажирский вагон.',
                ' 5 - Создать грузовой вагон.',
                ' 6 - Посмотреть список вагонов.',
                ' 7 - Прицепить вагон к поезду.',
                ' 8 - Отцепить вагон от поезда.',
                ' 9 - Создать маршрут.',
                ' 10 - Добавить промежуточную станцию в маршрут.',
                ' 11 - Удалить промежуточную станцию из маршрута.',
                ' 12 - Назначить маршрут поезду.',
                ' 13 - Переместить поезд по маршруту вперед.',
                ' 14 - Переместить поезд по маршруту назад.',
                ' 15 - Посмотреть список станций.',
                ' 16 - Посмотреть список поездов на станции.',
                BORDERLINE,
                '  0 - Для выхода из программы.']
    messages.each { |item| puts item }
  end

  def selected(menu_item)
    puts "Your choice: #{menu_item}" if menu_item != ''

    case menu_item
    when '1'
      create_station
    when '2'
      create_train_pass
    when '3'
      create_train_cargo
    when '4'
      create_wagon_pass
    when '5'
      create_wagon_cargo
    when '6'
      list_wagons
    when '7'
      attach_wagon
    when '8'
      detach_wagon
    when '9'
      create_route
    when '10'
      add_station
    when '11'
      delete_midway
    when '12'
      add_route_train
    when '13'
      move_forwards
    when '14'
      move_backwards
    when '15'
      list_stations
    when '16'
      list_trains_station
    else
      puts 'Повторите ввод.'
    end
  end

  def data_input(message)
    @args = []
    message.each { |mess| puts mess }
    @args << gets.chomp
  end

  def dublicate_name?(arr, name)
    arr.any? { |elem| elem.name == name.to_s }
  end

  def create_station
    message = ['Введите название станции:']
    name = data_input(message).first

    return if dublicate_name?(@stations, name)

    @stations << Station.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  def info_created
    puts 'Успешное создание.'
  end

  def error_message(e)
    puts e
  end

  def create_train_pass
    message = ['Введите номер поезда: Пример(12345; 123-AA; ccc-99; 1af-0a)']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@trains, name)

    @trains << PassengerTrain.new(name)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  def create_train_cargo
    message = ['Введите номер поезда: Пример(12345; 123-AA; ccc-99; 1af-0a)']
    name = data_input(message).first

    return unless name != '' && !dublicate_name?(@trains, name)

    @trains << CargoTrain.new(name)
    info_train_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  def create_wagon_pass
    @wagons << PassengerWagon.new
  end

  def create_wagon_cargo
    @wagons << CargoWagon.new
  end

  def list_wagons
    @wagons.each_with_index { |elem, index| puts "#{index + 1}. #{elem}" }
  end

  def choose_a_train
    message = @trains
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem.name}" }

    message = ['Выбрать поезд: ']
    index = data_input(message).first.to_i - 1
    @trains[index]
  end

  def attach_wagon
    return if @trains.size.zero? || @wagons.size.zero?

    train = choose_a_train

    suitable_wagon = @wagons.select { |wagon| wagon.type == train.type }.first

    return if suitable_wagon.nil?

    train.attach_wagon(suitable_wagon)
    @wagons.delete(suitable_wagon)
  end

  def detach_wagon
    return if @trains.size.zero? || @wagons.size.zero?

    train = choose_a_train

    return if train.wagons.size.zero?

    @wagons << train.detach_wagon
  end

  def selected_station_route
    message = @stations
    message.each_with_index { |elem, index| puts "#{index + 1}. #{elem.name}" }

    message = ['Выбрать станцию: ']
    index = data_input(message).first.to_i - 1
    @stations[index]
  end

  def choose_first_station
    puts 'Выберете начальную станцию для маршрута:'
  end

  def choose_last_station
    puts 'Выберете конечную станцию для маршрута:'
  end

  def create_route
    return if @stations.size < 2

    choose_first_station
    first = selected_station_route
    choose_last_station
    last = selected_station_route
    @routes << Route.new(first, last)
    info_created
  rescue StandardError => e
    error_message(e)
    retry
  end

  def selected_route
    message = @routes
    message.each_with_index { |elem, ind| puts "#{ind + 1}. #{elem.stations}" }

    message = ['Выбрать маршрут: ']
    index = data_input(message).first.to_i - 1
    @routes[index]
  end

  def message_number_route_add_station
    puts 'Введите номер маршрута в который хотите добавить станцию:'
  end

  def message_name_station
    puts 'Введите название станции:'
  end

  def add_station
    return if @routes.size.zero? || @stations.size < 3
    message_number_route_add_station
    route = selected_route

    message_name_station
    route.midway(selected_station_route)
  end

  def message_number_route_delete_station
    puts 'Введите номер маршрута из которого нужно удалить станцию:'
  end

  def message_number_station_delete
    puts 'Введите номер станции которую хотите удалить из маршрута:'
  end

  def delete_midway
    return if @routes.size.zero? || @stations.size < 3

    message_number_route_delete_station
    route = selected_route

    message_number_station_delete
    station = selected_station_route

    return if station == (route.stations.first && route.stations.last)

    route.delete_midway(station)
  end

  def message_number_add_route
    puts 'Введите номер поезда для которого нужно назначить маршрут:'
  end

  def message_number_route_train
    puts 'Введите номер маршрута который хотите назначить поезду:'
  end

  def add_route_train
    return if @trains.size.zero? || @routes.size.zero?

    message_number_add_route
    train = choose_a_train
    message_number_route_train
    route = selected_route
    train.route(route)
  end

  def message_number_train_move_forwards
    puts 'Введите номер поезда который нужно переместить на станцию вперед:'
  end

  def move_forwards
    return if @trains.size.zero?
    message_number_train_move_forwards
    choose_a_train.move_forwards
  end

  def message_number_train_move_backwards
    puts 'Введите номер поезда который нужно переместить на станцию назад:'
  end

  def move_backwards
    return if @trains.size.zero?
    message_number_train_move_backwards
    choose_a_train.move_backwards
  end

  def list_stations
    @stations.each_with_index { |elem, index| puts "#{index + 1}.#{elem.name}" }
  end

  def message_number_station_list_trains
    puts 'Введите номер станции на которой хотите посмотреть список поездов.'
  end

  def list_trains_station
    return if @stations.size.zero?
    message_number_station_list_trains
    station = selected_station_route
    puts "Список поездов на станции #{station.name}: #{station.trains}"
  end
end
