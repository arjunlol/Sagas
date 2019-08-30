module Sagas
  class Transaction

    attr_reader :commands

    def initialize
      @commands = []
    end

    def run_command(name: nil, catch_exceptions: [], &block)
      command = Sagas::Command.new(
        name: name, catch_exceptions: catch_exceptions, &block
      )
      commands.push(command)
    end
  end
end
