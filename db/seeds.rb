# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Organisation.destroy_all
Unit.destroy_all
User.destroy_all

org = Organisation.create!(name: "1107 W Chestnut", capacity: 4)

unit = Unit.create!(name: "Owen's Unit", number: "1E", organisation_id: org.id)

User.create!(name: "Owen Roth", role: 3, password: "111111", unit_id: unit.id, organisation_id: org.id, email: "owen@test.com", address: "1107 W Chestnut St", postal_code: "60642", main_address?: true, city: "Chicago")