# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Organization.rebuild!
OrganizationAuth.rebuild!

u = NewUser.new(
    email: 'test1@gmail.com',
		name: 'test1',
		password: 'password',
    password_confirmation: "password"
)
u.save!

u = NewUser.new(
    email: 'test2@gmail.com',
		name: 'test2',
		password: 'password',
    password_confirmation: "password"
)
u.save!
u = NewUser.new(
    email: 'test3@gmail.com',
		name: 'test3',
		password: 'password',
    password_confirmation: "password"
)
u.save!
u = NewUser.new(
    email: 'test4@gmail.com',
		name: 'test4',
		password: 'password',
    password_confirmation: "password"
)
u.save!