require 'spec_helper'

RSpec.describe Sagas do
  describe '#transaction' do
    it 'initializes a transaction' do
      expect(
        ::Sagas.transaction
      ).to be_a(Sagas::Transaction)
    end
  end
end
