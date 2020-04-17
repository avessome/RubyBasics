# frozen_string_literal: true

# documentation comment
require_relative 'module_company'

# documentation comment
class Wagon
  include Company
  attr_reader :type, :capacity, :free_capacity
  def initialize(type, capacity)
    @capacity = capacity.to_i
    @type = type
    validate!
    @free_capacity = @capacity
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Ошибка! Тип не указан!' if @type.nil? || @type.empty?
    raise 'Ошибка! Вместимость должна быть больше 0!' unless @capacity.positive?
  end
end
