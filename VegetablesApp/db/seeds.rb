# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

client1 = Client.create(name: 'Lucas', surname: 'Trump', address: 'Calle falsa 123', email:'lucas.trump@gmail.com', password: '1234567890', city:'madrid', zip:'43201',age:'20', gender:'male')
client2 = Client.create(name: 'Carmen', surname: 'Obama', address: 'Calle falsa 123', email:'carmen.obama@gmail.com', password: '1234567890', city:'reus', zip:'43202',age:'36', gender:'female')
client3 = Client.create(name: 'Juan', surname: 'Jara', address: 'Calle falsa 123', email:'juan.jara@gmail.com', password: '1234567890', city:'barcelona', zip:'43203',age:'30', gender:'male')
client4 = Client.create(name: 'Mar', surname: 'Virgili', address: 'Calle falsa 123', email:'mar.virgili@gmail.com', password: '1234567890', city:'tarragona', zip:'43204',age:'27', gender:'female')
client5 = Client.create(name: 'Antonia', surname: 'Mandona', address: 'Calle falsa 123', email:'antonia.mandona@gmail.com', password: '1234567890', city:'riudoms', zip:'43205',age:'40', gender:'female')

category1 = Category.create(name: 'fruit')
category2 = Category.create(name: 'summer')
category3 = Category.create(name: 'winter')
category4 = Category.create(name: 'spring')
category5 = Category.create(name: 'autumn')
category6 = Category.create(name: "salad")
category7 = Category.create(name: 'sweet')
category8 = Category.create(name: 'bitter')
category9 = Category.create(name: 'dried fruits')

