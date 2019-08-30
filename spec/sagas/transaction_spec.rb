require 'spec_helper'

RSpec.describe Sagas::Transaction do
  let(:transaction) { Sagas.transaction }

  describe '#run_command' do
    context 'when no exception is raised' do
      it 'triggers performs' do
        expect do
          transaction.run_command(name: 'Put') do
            perform do
              puts 'performing'
            end

            undo do
              puts 'undoing'
            end
          end
        end.to output(a_string_including('performing')).to_stdout
      end

      it 'does not trigger undos' do
        expect do
          transaction.run_command(name: 'Put') do
            perform do
              puts 'performing'
            end

            undo do
              puts 'undoing'
            end
          end
        end.not_to output(a_string_including('undoing')).to_stdout
      end

      it 'push command to the list of commands' do
        expect do
          transaction.run_command(name: 'Put') do
            perform do
              puts 'performing'
            end

            undo do
              puts 'undoing'
            end
          end
        end.to change { transaction.commands.length }.from(0).to(1)
      end
    end

    context 'when exception is raised' do
      it 'triggers undos' do
        expect do
          exceptions_to_catch = [StandardError]
          transaction.run_command(name: 'Put', catch_exceptions: exceptions_to_catch) do
            perform do
              raise StandardError.new('Error while trying to perform')
              puts 'performing'
            end

            undo do
              puts 'undoing'
            end
          end
        end.to output(a_string_including('undoing')).to_stdout
      end
    end
  end
end
