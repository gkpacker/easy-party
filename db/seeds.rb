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

categories.each do |option|
  category = Category.new(name: option)
  category.save!
end
puts "Done ! #{Category.all.count} categories added to the database."

# --------- Seeding Users DB --------- #
# 1) ------ Organizers ------- #
organizers = []

organizer_first_names = %w(mathieu roberto marcelo diego)
organizer_last_names = ["le roux", "barros", "de polli", "van dyk"]
organizer_usernames = %w(matleroux robertobarros mdepolli diegolearnstocode)

professional_first_names = %w(andré bruno césar daniel daniel danielle fabricio marcos miguel oscar rodrigo thiago val)
professional_last_names = %w(miotto parga fuster carvalho topper alvino zanette scorzoni aguirre ortiz arroyo scatigno prando)
professional_usernames = %w(andremiotto brunoparga cesarfuster danielbpc2 dantopper danialvino fdzanette mscorzoni migueldaguirre oscarlaf03 rodjra tgiliberti vcprando)

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

  organizer.save!
end

puts "Done ! #{User.where(role: 'Organizador').count} organizers added to the User database."

# 2) ------ Professionals ------- #
15.times do
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

  professional.save!
end

puts "Done ! #{User.where(role: 'Profissional').count} professionals added to the User database."

events = []
titles = ["despedida de solteiro de ", "aniversario de ", "casamento de", "cocktail para", "housewarming de"]
5.times do
  event = Event.new
  event.organizer = User.where(role: "Organizador").sample
  event.title = "#{titles.sample.capitalize} #{Faker::Name.first_name.capitalize}"
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
  job.event = Event.all.sample
  job.professional = User.where(role: "Profissional").sample
  job.price = job.professional.price_per_hour
  job.save!
  jobs << job
end
puts "Done ! #{Job.all.count} jobs added to the database."
