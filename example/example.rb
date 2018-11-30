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

  puts num
end
