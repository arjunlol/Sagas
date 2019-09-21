require 'sagas'

num = 0

transaction = Sagas.transaction

exceptions_to_catch = [StandardError]
transaction.run_command(name: 'Add', catch_exceptions: exceptions_to_catch) do
  perform do
    num += 10
  end

  undo do
    num -= 10
  end
end

transaction.run_command(name: 'Multiply', catch_exceptions: exceptions_to_catch) do
  perform do
    num *= 2
    raise StandardError.new('Error while trying to perform')
  end

  undo do
    num /= 2
  end
end

transaction.run_command(name: 'Subtract', catch_exceptions: exceptions_to_catch) do
  perform do
    num -= 7
  end

  undo do
    num += 7
  end
end

# num => 0
