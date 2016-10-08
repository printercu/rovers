module Rovers
  # Plateau is a container for its rovers.
  class Plateau
    attr_reader :width, :length, :rovers

    def initialize(width, length)
      @width = width
      @length = length
      @rovers = []
    end

    def add_rover(*args)
      Rover.new(self, *args).tap { |x| rovers.push(x) }
    end
  end
end
