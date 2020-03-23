require 'rails_helper'

RSpec.describe Property, type: :model do
  let (:main_property) {create(:property)}
  let (:valid_property) {build(:property)}
  
  describe "Testing model validations" do 
    #Validate That we have a valid factory to work with
    it "has a valid factory" do 
      expect(main_property).to be_valid
    end

    it "is invalid without a description" do 
  	  expect(build(:property, description: nil)).not_to be_valid
    end
  end


end
