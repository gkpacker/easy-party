# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

# --------- Seeding categories DB --------- #
categories = ["Animação de Festas de crianças", "Wedding Planner", "Banda", "Bartender", "Brindes e lembrancinhas", "Buffet completo", "Churrasqueiro", "Decoração", "Djs", "Fotografo", "Garçons e Copeiras", "Segurança"]
prices = [50, 30, 100, 90, 30, 40, 40, 40, 150, 200, 60, 50]

# categories.each do |option|
#   category = Category.new(name: option)
#   category.save
# end
# puts "Done ! #{Category.all.count} categories added to the database."

# --------- Seeding Users DB --------- #
# 1) ------ Organizers ------- #

5.times do
  organizer = User.new

  user = JSON.parse(open('https://randomuser.me/api/').read)['results'].first

  organizer.first_name = user["name"]["first"].capitalize
  organizer.last_name = user["name"]["last"] .capitalize
  organizer.email = user["email"]
  organizer.phone_number = user["phone"]
  organizer.password = "123456"
  organizer.remote_photo_url = user["picture"]["large"]
  organizer.role = "Organizador"

  organizer.save
end

puts "Done ! #{User.where(role: 'Organizador').count} organizers added to the User database."

# 2) ------ Professionals ------- #
50.times do
  professional = User.new

  user = JSON.parse(open('https://randomuser.me/api/').read)['results'].first

  professional.first_name = user["name"]["first"].capitalize
  professional.last_name = user["name"]["last"] .capitalize
  professional.email = user["email"]
  professional.phone_number = user["phone"]
  professional.password = "123456"
  professional.remote_photo_url = user["picture"]["large"]
  professional.role = "Profissional"

  random_day = (1..7).to_a.sample
  professional.availability = %w(Segunda Terça Quarta Quinta Sexta Sábado Domingo).sample(random_day)
  professional.city = %w(Pinheiros Morumbi Itaim Campinas Sorocaba Santos Jardins).sample

  random_index = (0..11).to_a.sample
  professional.category = Category.all.sample
  professional.price_per_hour = prices[random_index]

  professional.save
end

puts "Done ! #{User.where(role: 'Profissional').count} professionals added to the User database."

events = []
titles = ["despedida de solteiro de ", "aniversario de ", "casamento de", "cocktail para", "housewarming de"]
10.times do
  event = Event.new
  event.organizer = User.where(role: "Organizador").sample
  event.title = "#{titles.sample.capitalize} #{Faker::Name.first_name.capitalize}"
  event.date = Faker::Date.forward(60)
  event.location = %w(Pinheiros Morumbi Itaim Campinas Sorocaba Santos Jardins).sample
  event.description = Faker::Lorem.paragraph
  event.save
end
puts "Done ! #{Event.all.count} events added to the database."


jobs = []
100.times do
  job = Job.new
  job.event = Event.all.sample
  job.professional = User.where(role: "Profissional").sample
  job.price = job.professional.price_per_hour
  job.accepted = [true, false].sample
  if job.accepted
    job.done = [true, false].sample
    if job.done
      random_rating = (1..5).to_a.sample
      job.rating = [nil, random_rating].sample
      if job.rating
        job.comment = Faker::Lorem.paragraph
      end
    end
  end
  job.save
end
puts "Done ! #{Job.all.count} jobs added to the database."
