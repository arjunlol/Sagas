require 'spec_helper'

RSpec.describe Saga do
  describe '#run' do
    before(:each) do
      @change = false
      @test_effect = {
        name: 'Test',
        perform: ->() {
          @change = true
        },
        undo: ->(side_effect) {
          @change = false
        }
      }
      @fail_effect = {
        name: 'Error',
        perform: ->() {
          raise 'error'
        },
        undo: ->(side_effect) {}
      }
    end

    it 'performs the provided function' do
      Saga.transaction do |s|
        s.run(@test_effect)
      end
      expect(@change).to eq(true)
    end

    it 'does not perform future functions when exceptions are raised' do
      Saga.transaction do |s|
        s.run(@fail_effect)
        s.run(@test_effect)
      end
      expect(@change).to eq(false)
    end

    it 'rolls back with compensation functions when exceptions are raised' do
      Saga.transaction do |s|
        s.run(@test_effect)
        expect(@change).to eq(true)
        s.run(@fail_effect)
      end
      expect(@change).to eq(false)
    end
  end
end