# Sagas
A dependency-free library to manage distributed transactions in Ruby

Based on the sagas design pattern (http://www.cs.cornell.edu/andru/cs711/2002fa/reading/sagas.pdf)

## Contents

* [Installation](#installation)
* [Using Sagas](#using-sagas)
* [License](#license)


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

Saga.transaction do |s|
  s.run(
    name: 'Add',
    perform: ->(){
      num += 10
    },
    undo:->(side_effect){
      num -= 10
    }
  );

  s.run(
    name: 'Multiply',
    perform: ->(){
      num *= 2
      raise "error"
    },
    undo:->(side_effect){
      num /= 2
    }
  );

  s.run(
    name: 'Subtract',
    perform: ->(){
      num -= 7
    },
    undo:->(side_effect){
      num += 7
    }
  );

  puts num #outputs 0 (will perform all undo effects up to the exception abort transaction) 
end

```

## License 
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
