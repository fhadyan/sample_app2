# By using the symbol ':user', we get Factory Girl to simulate the User model.
#require 'faker'
Factory.define :user do |user|
	user.name                  "fadhlil hadyan"
	user.email                 "fh@email.com"
	user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
	"person-{n}@example.com"
end

Factory.define :micropost do |micropost|
	micropost.content "foo bar"
	micropost.association :user
end