# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
options = ["Animação de Festas", "Assessor de Eventos", "Bandas e cantores", "Bartenders", "Brindes e lembrancinhas", "Buffet completo", "Churrasqueiro", "Confeiteira", "Decoração", "Djs", "Equipamento para festas", "Fotografia", "Garçons e Copeiras", "Gravação de vídeos", "Recepcionistas e cerimonialistas", "Segurança"]
options.each do |option|
  puts "Categories #{option} created"
  categorie = Category.new(name: option)
  categorie.save
end

 professional1 = User.new(first_name: "Allan",
                          last_name: "Maron",
                          role: "Professional",
                          phone_number:"87857485",
                          city: "Sao paulo",
                          availability: "seg a sex",
                          price_per_hour: "493",
                          category_id:1,
                          email: "allanmaron@gmail.com",
                          password_confirmation: "1234567",
                          password: "1234567")

professional1.save!
