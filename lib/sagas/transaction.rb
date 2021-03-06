module Sagas
  class Transaction

    attr_reader :commands, :halted

    def initialize
      @commands = []
      @halted = false
    end

    def run_command(name: nil, catch_exceptions: [], &block)
      command = Sagas::Command.new(
        name: name, catch_exceptions: catch_exceptions, transaction: self, &block
      )
    end

    def roll_back
      commands.reverse.each { |command| command.do_undo.call }
      commands.clear
      @halted = true
    end

    def halted?
      halted
    end
  end
end
