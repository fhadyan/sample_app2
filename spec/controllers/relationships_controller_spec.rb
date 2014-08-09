require 'spec_helper'

describe RelationshipsController do
	
	describe "access control" do

		it "should require sign in to create" do
			post :create
			response.should redirect_to(signin_path)
		end

		it "should require sign in to destroy" do
			delete :destroy, :id => 1
			response.should redirect_to(signin_path)
		end
	end

	describe "post 'create" do

		before(:each) do
			@user = test_sign_in(Factory(:user))
			@followed = Factory(:user, :email => "aaaaaaaa@aaaaa.com")
		end

		it "should create a relationship" do
			lambda do
				post :create, :relationship => { :followed_id => @followed}
				response.should be_redirect
			end.should change(Relationship, :count).by(1)
		end	

		it "should create a relationship using ajax" do
			labmda do
				xhr :post, :create, :relationship => { :followed_id => @followed }
				response.should be_success
			end.should change(Relationship, :count).by(1)
		end
	end

	describe "destroy 'delete'" do

		before(:each) do
			@user = test_sign_in(Factory(:user))
			@followed = Factory(:user, :email => "aaaaaaaa@aaaaa.com")
			@user.follow!(@followed)
			@relationship = @user.relationships.find_by_followed_id(@followed)
		end

		it "should destroy relationship" do
			lambda do
				delete :destroy, :id => @relationship
				response.should be_redirect
			end.should change(Relationship, :count).by(-1)
		end

		it "should destroy relationship using ajax" do
			lambda do
				xhr :delete, :destroy, :id => @relationship
				response.should be_success
			end.should change(Relationship, :should).by(-1)
		end
	end
end