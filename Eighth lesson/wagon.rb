# frozen_string_literal: true

# documentation comment
require_relative 'module_company'
require_relative 'module_accessors'
require_relative 'validation'

# documentation comment
class Wagon
  include Accessor
  include Company
  include Validation

  attr_reader :type, :capacity, :free_capacity

  attr_accessor_with_history :color

  def initialize(type, capacity)
    @capacity = capacity.to_i
    @type = type
    validate!
    @free_capacity = @capacity
  end

  def loaded_capacity
    @capacity - @free_capacity
  end
end
