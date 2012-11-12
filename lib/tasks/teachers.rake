# encoding: utf-8

namespace :create do
  desc "Create 100 teachers with specialities in db."

  task :teachers => :environment do
    sps = Speciality.all
    if sps.any?
      cidade = Cidade.find_by_nome("Rio de Janeiro")
      estado = Estado.find_by_sigla("RJ")
      100.times do |i|
        name = Faker::Name.name
        tel = Faker::PhoneNumber.cell_phone
        email = Faker::Internet.email(name)
        description = Faker::Lorem.sentence(3)
        t = Teacher.create(:name => name, :tel => tel, :email => email, :description => description, :cidade => cidade, :estado => estado)
        3.times do
          t.specialities << sps.sample
        end
        puts "Teacher created: #{t.name} - Specialities: #{t.specialities.map(&:name).join(", ")}"
      end
    end
  end

end
