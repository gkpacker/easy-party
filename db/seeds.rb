# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

options = ["Animação de Festas", "Assessor de Eventos", "Bandas e cantores", "Bartenders", "Brindes e lembrancinhas", "Buffet completo", "Churrasqueiro", "Confeiteira", "Decoração", "Djs", "Equipamento para festas", "Fotografia", "Garçons e Copeiras", "Gravação de vídeos", "Recepcionistas e cerimonialistas", "Segurança"]
options.each do |option|
  categorie = Category.new(name: option)
  categorie.save!
end
puts "Done ! #{Category.all.count} categories added to the database."

organizers = []
10.times do
  organizer = User.new
  organizer.first_name = Faker::Name.first_name.capitalize
  organizer.last_name = Faker::Name.last_name.capitalize
  organizer.email = Faker::Internet.email
  organizer.password = "123456"
  organizer.photo = Cloudinary::Uploader.upload(Faker::LoremPixel.image)
  organizer.phone_number = Faker::PhoneNumber.phone_number
  organizer.role = "Organizador"
  organizer.save!
  organizers << organizer
end
puts "Done ! #{User.where(role: 'Organizador').count} organizers added to the User database."

professionals = []
20.times do
  professional = User.new
  professional.first_name = Faker::Name.first_name
  professional.last_name = Faker::Name.last_name
  professional.email = Faker::Internet.email
  professional.photo = Cloudinary::Uploader.upload(Faker::LoremPixel.image)
  professional.password = "123456"
  professional.phone_number = Faker::PhoneNumber.phone_number
  professional.role = "Profissional"
  random_number = (1..8).to_a.sample
  professional.availability = %w(Segunda Terça Quarta Quinta Sexta Sábado Domingo).sample(random_number)
  professional.price_per_hour = %w(20 30 40 50 60 70 80 90 100).sample.to_i
  professional.city = %w(Pinheiros Morumbi Itaim Campinas Sorocaba Santos Jardins).sample
  professional.category = Category.all.sample
  professional.save!
  professionals << professional
end
puts "Done ! #{User.where(role: 'Profissional').count} professionals added to the User database."

events = []
titles = ["despedida de solteiro de ", "aniversario de ", "casamento de", "cocktail para", "housewarming de"]
5.times do
  event = Event.new
  event.organizer = User.where(role: "Organizador").sample
  event.title = "#{titles.sample} #{Faker::Name.first_name.capitalize}"
  event.date = Faker::Date.forward(60)
  event.location = %w(Pinheiros Morumbi Itaim Campinas Sorocaba Santos Jardins).sample
  event.description = Faker::Lorem.paragraph
  event.save!
  events << event
end
puts "Done ! #{Event.all.count} events added to the database."


jobs = []
15.times do
  job = Job.new
  job.price = %w(20 30 40 50 60 70 80 90 100).sample.to_i
  job.event = Event.all.sample
  job.professional = User.where(role: "Profissional").sample
  job.rating = (1..5).to_a.sample
  job.comment = Faker::Lorem.paragraph
  job.save!
  jobs << job
end
puts "Done ! #{Job.all.count} jobs added to the database."
