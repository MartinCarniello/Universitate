# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.find_or_create_by(name: :student)
Role.find_or_create_by(name: :teacher)

[
  {first_name: 'Jorge', last_name: 'Lopez', email: 'jorgelopez@gmail.com', password: '123456'},
  {first_name: 'Hada', last_name: 'Cernudita', email: 'hada@gmail.com', password: '123456'},
  {first_name: 'Mateiquito', last_name: 'Avantaggiatito', email: 'mate@gmail.com', password: '123456'},
  {first_name: 'Patin', last_name: 'Gordo', email: 'patingordo@gmail.com', password: '123456'}

].each do |user|
  if !User.find_by(email: user[:email])
    user = User.create!(user)
    user.add_role :teacher
  end
end
