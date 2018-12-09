class Effect
  attr_reader :name, :perform, :undo
  attr_accessor :side_effect

  def initialize(name:, perform:, undo:)
    @name = name
    @perform = perform
    @undo = undo
  end
end

class Saga
  def initialize
    @effects = []
    # Can be :abort, :error, or :ok
    @transaction_state = :ok
  end

  def self.transaction(&block)
    block.call(Saga.new)
  end

  def run(name:, perform:, undo:)
    add_stage(name: name, perform: perform, undo: undo)
    execute_stage if @transaction_state == :ok
  end

  def add_stage(name:, perform:, undo:)
    @effects.push(Effect.new(name: name, perform: perform, undo: undo))
  end

  def execute_stage
    @effects.last.side_effect = @effects.last.perform.call()
  rescue => e
    @transaction_state = :abort
    @effects.reverse_each do |effect|
      effect.undo.call(effect.side_effect)
    end
  end
end