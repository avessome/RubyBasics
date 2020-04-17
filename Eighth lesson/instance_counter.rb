# frozen_string_literal: true

# documentation comment
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # documentation comment
  module ClassMethods
    def instances
      @instances ||= 0
    end

    def register_count
      @instances ||= 0
      @instances += 1
    end
  end

  # documentation comment
  module InstanceMethods
    private

    def register_instance
      self.class.register_count
    end
  end
end
