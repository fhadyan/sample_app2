
namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		require 'faker'
		Rake::Task['db:reset'].invoke
		make_user
		make_micropost
		make_relationship
	end
end

def make_user
	admin = User.create!(:name => "Example User",
								 :email => "example@railstutorial.org",
								 :password => "foobar",
								 :password_confirmation => "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(:name => name,
									 :email => email,
									 :password => password,
									 :password_confirmation => password)
		end	
end

def make_micropost
	User.all(:limit => 6).each do |user|
			50.times do
				user.microposts.create!(:content => Faker::Lorem.sentences(5))
			end
		end
end

def make_relationship
	users = User.all
	user = User.first
	following = users[1..50]
	followers = users[3..30]
	following.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end