# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html


Topic.first_or_create([
  { title: 'Server setup', description: 'Server setup topics go here' },
  { title: 'Rails apps', description: 'Rails apps topics go here' },
  { title: 'SQL databases', description: 'SQL databases topics go here' },
  { title: 'Mongo', description: 'Mongo topics go here' },
  { title: 'Project reviews', description: 'Project reviews topics go here' },
  { title: 'Mentoring new people', description: 'Mentoring new people topics go here' }
])
