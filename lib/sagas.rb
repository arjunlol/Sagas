module Sagas
  require 'sagas/transaction'
  require 'sagas/command'

  def self.transaction
    Sagas::Transaction.new
  end
end
