# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

specialty = ["généraliste", "ophtalmo", "dentiste", "ORL"]

10.times do 
  doctor = Doctor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, specialty: specialty.sample, zip_code: Faker::Address.zip_code)
end

20.times do 
  patient = Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
end

30.times do 
  appointments = Appointment.create(doctor: Doctor.all.sample, patient: Patient.all.sample, date: Faker::Date.between(from: '2024-02-10', to: '2024-05-25'))
end