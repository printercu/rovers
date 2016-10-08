module Rovers
  class Error < StandardError; end

  require 'rovers/plateau'
  require 'rovers/rover'

  autoload :Cli, 'rovers/cli'
end
