require 'rails_helper'

RSpec.describe User, type: :model do 
  let(:user1) {create :user}
  
  
	#Validate That the default factory we have is valid
	it "has a valid factory" do 
	  expect(user1).to be_valid
	end

	it "is invalid without an email" do 
	  expect(build(:user, email: nil)).not_to be_valid
	end
	  
	it "is invalid without a password" do 
	  expect(build(:user, password: nil)).not_to be_valid
	end

	#Test The email formatting function
	it "is invalid with wrong email format" do 
	  expect(build(:user, email: 'user.com')).not_to be_valid
	end
	
	#make sure we cannot use the same email
	it "does not allow same email to be used" do 
	  expect(build(:user, email: user1.email)).not_to be_valid
	end

end