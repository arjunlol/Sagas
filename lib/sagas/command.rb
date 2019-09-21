module Sagas
  class Command

    attr_accessor :name, :catch_exceptions, :do_perform, :do_undo, :transaction

    def initialize(name: nil, catch_exceptions: [], transaction: nil, &block)
      @name = name
      @catch_exceptions = catch_exceptions
      @transaction = transaction
      instance_eval(&block) if block_given?
      transaction.commands.push(self)
      execute
    end

    def perform(&block)
      @do_perform = block
    end

    def undo(&block)
      @do_undo = block
    end

    def execute
      begin
        do_perform.call
      rescue *catch_exceptions
        transaction.roll_back
      end
    end
  end
end
