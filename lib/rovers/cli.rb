module Rovers
  module Cli
    module_function

    def start
      unless ARGV.size == 1
        STDERR.puts 'Script must be called with single argument - input file'
        exit 1
      end
      process(ARGV[0])
    end

    def process(filename)
      input = read_input(filename)
      input.each do |(rover, instructions)|
        rover.process_instructions(instructions)
        puts rover.position.join(' ')
      end
    end

    def read_input(filename) # rubocop:disable AbcSize
      result = []
      File.open(filename) do |file|
        plateau_width, plateau_length = file.gets.split.map(&:to_i)
        plateau = Plateau.new(plateau_width, plateau_length)
        while position = file.gets # rubocop:disable AssignmentInCondition
          instructions = file.gets.strip
          x, y, orientation = position.split
          rover = plateau.add_rover(x.to_i, y.to_i, orientation)
          result.push([rover, instructions])
        end
      end
      result
    end
  end
end
