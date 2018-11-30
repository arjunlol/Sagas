require 'sagas'

num = 0

Saga.transaction do |s|
  s.run(
    name: 'Add',
    transaction: ->(){
      num += 10
      raise "Error"
    },
    compensation:->(side_effect){
      num -= 10
    }
  );

  puts num
end
