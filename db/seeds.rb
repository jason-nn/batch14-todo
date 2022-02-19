# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

jason = User.create(email: 'jason.ho@obf.ateneo.edu', password: 'password')

todo = jason.categories.create(name: 'To Do')
doing = jason.categories.create(name: 'Doing')
done = jason.categories.create(name: 'Done')

todo.tasks.create(name: 'Add README', deadline: Date.today + 2)
todo.tasks.create(name: 'Add API for sortable calls', deadline: Date.today + 2)
todo.tasks.create(name: 'Add project to portfolio', deadline: Date.today + 2)
todo.tasks.create(
  name: 'Refactor global variable to use cookies instead',
  deadline: Date.today + 2,
)

doing.tasks.create(name: 'Add seed data', deadline: Date.today)

done.tasks.create(name: 'Write tests', deadline: Date.today - 2)
done.tasks.create(name: 'Add javascript for sortable', deadline: Date.today - 2)
