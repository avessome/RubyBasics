require_relative 'module_company'
class Wagon
  include Company

  attr_reader :type
  def initialize(type)
    @type = type
  end
end
