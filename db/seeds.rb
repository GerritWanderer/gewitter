# ----------------------------
# Enter your account details -
# ----------------------------
user = User.create!(:username => 'your_name',
             :firstname => Faker::Name.first_name,
             :lastname => Faker::Name.last_name,
             :email => "your_name@example.org",
             :password => "your_password")
user.sign_in_count = 1
user.confirmed_at = "2011-01-01 12:00:00"
user.save


# create some dummy users
10.times do
	user = User.create!(:username => Faker::Name.first_name,
	             :firstname => Faker::Name.first_name,
	             :lastname => Faker::Name.last_name,
	             :email => Faker::Internet.email,
	             :password => "dummy_password")
	user.sign_in_count = 1
	user.confirmed_at = "2011-01-18 12:10:00"
	user.save
end

# and create dummy messages of all users
100.times do
  username = rand(10)==1 ? User.first.username : User.all.shuffle.first.username
  message = Message.create!(:user_id => User.all.shuffle.first.id,
                            :text => "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor. You know what I mean #{username} ?")
end
