# Sagas

[![Gem Version](https://badge.fury.io/rb/sagas.svg)](https://badge.fury.io/rb/sagas)
[![Build Status](https://travis-ci.org/arjunlol/Sagas.svg?branch=master)](https://travis-ci.org/arjunlol/Sagas)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/arjunlol/Sagas.svg)](https://codeclimate.com/github/arjunlol/Sagas/maintainability)

A dependency-free library to manage transactions in Ruby

Based on the sagas design pattern (http://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf)

## Contents

- [Installation](#installation)
- [Using Sagas](#using-sagas)
- [License](#license)

## Installation

Add this line to your application's Gemfile:

```
gem 'sagas'
```

And then execute:

```
$ bundle
```

Or Install locally:

```
$ gem install sagas
```

## Using Sagas

```
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

  puts num #outputs 0 (will perform all undo effects up to the exception abort transaction)

```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
