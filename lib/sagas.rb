class Saga
  def initialize
    @effects = []
    @transaction = {}
    @compensation = {}
  end

  def self.transaction(&block)
    block.call(Saga.new)
  end

  def run(name:, transaction:, compensation:)
    side_effect = transaction.call()
  rescue => e
    compensation.call(side_effect)
  end
end