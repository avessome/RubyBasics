class Station
  @@all = 0

  attr_reader :trains, :name
  def initialize(name)
    @@all += 1
    @name = name
    @trains = []
  end

  def self.all
    @@all
  end

  def arrive(train)
    @trains << train unless trains.include?(train)
  end

  def return_type(type)
    @trains.select { |train| train.type == type }
  end

  def delete(train)
    @trains.delete(train)
  end
end
