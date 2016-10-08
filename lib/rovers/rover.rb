module Rovers
  # Rover is initialized with plateau, its coordinates and orientation
  # (usually using `Plateau#add_rover`) and can process_instructions.
  class Rover
    attr_reader :plateau, :x, :y, :orientation

    RIGHT_TO = {
      'N' => 'E',
      'E' => 'S',
      'S' => 'W',
      'W' => 'N',
    }.freeze
    LEFT_TO = RIGHT_TO.invert.freeze
    ORIENTATIONS = RIGHT_TO.keys.freeze

    class InvalidInstruction < Error; end

    def initialize(plateau, x, y, orientation)
      unless ORIENTATIONS.include?(orientation)
        raise ArgumentError, "Invalid orientation: #{orientation}"
      end
      @plateau = plateau
      @x = x
      @y = y
      @orientation = orientation
    end

    def position
      [x, y, orientation]
    end

    def process_instructions(instructions)
      instructions.chars.each do |instruction|
        case instruction
        when 'L' then turn_left
        when 'R' then turn_right
        when 'M' then move
        else raise InvalidInstruction, "Invalid instruction: #{instruction}"
        end
      end
    end

    def turn_left
      @orientation = LEFT_TO[orientation]
    end

    def turn_right
      @orientation = RIGHT_TO[orientation]
    end

    def move
      case orientation
      when 'N' then @y += 1
      when 'S' then @y -= 1
      when 'E' then @x += 1
      when 'W' then @x -= 1
      end
    end
  end
end
