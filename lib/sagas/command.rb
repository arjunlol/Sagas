module Sagas
  class Command

    attr_accessor :name, :catch_exceptions, :do_perform, :do_undo

    def initialize(name: nil, catch_exceptions: [], &block)
      @name = name
      @catch_exceptions = catch_exceptions
      instance_eval(&block) if block_given?
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
        do_undo.call
      end
    end
  end
end
