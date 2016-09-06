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
  {name: 'Matemática'},
  {name: 'Lengua'},
  {name: 'Inglés'},
  {name: 'Informática'},
  {name: 'Biología'}
].each { |subject| Subject.create!(subject) if !Subject.find_by(name: subject[:name]) }

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

[
  {teacher_profile_id: '1', name_of_the_place: 'UBA' , period_start: '2013-02-02', period_end: '2014-02-02', description: 'Contador', experience_type: :study},
  {teacher_profile_id: '2', name_of_the_place: 'UADE', period_start: '2013-02-01', period_end: '2015-02-02', description: 'Abogado', experience_type: :study},
  {teacher_profile_id: '3', name_of_the_place: 'UNQ', period_start: '2013-02-03', period_end: '2013-12-02', description: 'Programador', experience_type: :study},
  {teacher_profile_id: '4', name_of_the_place: 'UTN', period_start: '2013-12-02', period_end: '2017-02-02', description: 'Ingeniero', experience_type: :study},
  {teacher_profile_id: '2', name_of_the_place: 'Despegar', period_start: '2015-02-02', period_end:'2016-02-02' , description: 'Programar el sitio web', experience_type: :work},
].each { |exp| TeacherExperience.create!(exp) if !TeacherExperience.find_by(id: exp[:id]) }


matematica = Subject.find_by_name("Matemática")
lengua = Subject.find_by_name("Lengua")
ingles = Subject.find_by_name("Inglés")
informatica = Subject.find_by_name("Informática")
biologia = Subject.find_by_name("Biología")

user = User.find_by_email("jorgelopez@gmail.com")
user.teacher_profile.subjects.push(matematica) unless user.teacher_profile.subjects.detect { |subject| subject.name == matematica.name }
user.teacher_profile.subjects.push(lengua) unless user.teacher_profile.subjects.detect { |subject| subject.name == lengua.name }

user = User.find_by_email("hada@gmail.com")
user.teacher_profile.subjects.push(ingles) unless user.teacher_profile.subjects.detect { |subject| subject.name == ingles.name }

user = User.find_by_email("mate@gmail.com")
user.teacher_profile.subjects.push(matematica) unless user.teacher_profile.subjects.detect { |subject| subject.name == matematica.name }
user.teacher_profile.subjects.push(informatica) unless user.teacher_profile.subjects.detect { |subject| subject.name == informatica.name }

user = User.find_by_email("patingordo@gmail.com")
user.teacher_profile.subjects.push(matematica) unless user.teacher_profile.subjects.detect { |subject| subject.name == matematica.name }
user.teacher_profile.subjects.push(ingles) unless user.teacher_profile.subjects.detect { |subject| subject.name == ingles.name }
user.teacher_profile.subjects.push(biologia) unless user.teacher_profile.subjects.detect { |subject| subject.name == biologia.name }

