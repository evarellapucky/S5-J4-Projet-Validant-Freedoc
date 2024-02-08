# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
City.destroy_all
Doctor.destroy_all
Patient.destroy_all
Appointment.destroy_all
require 'faker'

cities = []
10.times do
  city = City.create(name: Faker::Address.city)
  cities << city
end
specialties = ["Pédiatrie", "Cardiologie", "Dermatologie", "Gastro-entérologie", "Gynécologie", "Neurologie", "Oncologie", "Ophtalmologie", "Orthopédie", "Oto-rhino-laryngologie (ORL)", "Pneumologie", "Radiologie", "Rhumatologie", "Urologie", "Chirurgie générale", "Chirurgie orthopédique", "Chirurgie plastique", "Chirurgie cardiaque", "Chirurgie vasculaire", "Médecine interne"]
specialties.each_with_index do |i, index|
  Specialty.create!(
    name: i
  )
end

10.times do 
  doctor = Doctor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: Faker::Address.zip_code, city_id: cities[rand(0..9)].id)
end

20.times do 
  patient = Patient.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city_id: cities[rand(0..9)].id)
end

30.times do 
  appointments = Appointment.create(doctor: Doctor.all.sample, patient: Patient.all.sample, date: Faker::Time.between_dates(from: Date.today, to: Date.today + 365, period: :day), city_id: cities[rand(0..9)].id)
end

doctors = Doctor.all # array of all doctors
doctors.each_with_index do |doctor, index| # each doctor will have one or more specialties
  
  random_nb = rand(1..5) # this doctor will have random_nb specialties
  mixed_specialties = Specialty.all.shuffle
  
  i = 0
  random_nb.times do |i|
    DoctorSpecialty.create!(
      doctor_id: doctor.id,
      specialty_id: mixed_specialties[i].id,
    )
    i += 1
  end

  if random_nb == 1
    puts "Doctor n°#{index+1} got #{random_nb} random specialty!"
  else
    puts "Doctor n°#{index+1} got #{random_nb} random and different specialties!"
  end
end