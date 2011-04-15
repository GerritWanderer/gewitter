require 'Faker'

Factory.define :user do |f|
	f.username {Faker::Name.first_name}
	f.email {Faker::Internet.email}
	f.firstname {Faker::Name.first_name}
	f.lastname {Faker::Name.last_name}
	f.password {"#{Faker::Name.first_name}#{Faker::Name.last_name}"}
	f.sign_in_count {1}
	f.confirmed_at {Date.today.strftime("%Y-%m-%d 09:00")}
end