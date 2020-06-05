
RSpec.describe Property, type: :model do
  let (:main_property) {create(:property)}
  
  let (:property_with_pic) {create :property, :with_picture}

  
  describe "Testing model validations" do 
    #Validate That we have a valid factory to work with
    it "has a valid factory" do 
      expect(main_property).to be_valid
    end
    it "has a valid factory with picture" do
      expect(property_with_pic).to be_valid
    end

    it "is invalid without a description" do 
  	  expect(build(:property, description: nil)).not_to be_valid
    end

    it "can have a picture attached" do 
      expect(property_with_pic.property_picture).to be_attached
    end

    it "can have no picture attached" do 
      expect(main_property.property_picture).to_not be_attached
    end
  end

  describe "Attaching Picture" do 
    before do 
      @property = create(:property)
      @property.property_picture.attach(io: File.open("/home/dev/trunfo6/spec/factories/files/home.jpg"), filename: "property_pic.jpg", content_type: "image/jpg")

      @invalid_property = create(:property)
      @invalid_property.property_picture.attach(io: File.open("/home/dev/trunfo6/spec/factories/files/home.pdf"), filename: "property_pic.pdf", content_type: "application/pdf")
    end
    
    context "With a valid image" do 
      it "Attaches the image" do 
      expect(@property.property_picture).to be_attached
      end
    end

    context "With an invalid image" do 
            
      it "Does not attach an image" do 
        expect(@invalid_property.property_picture.persisted?).to be_falsy
      end

      it "Returns an error" do 
        expect(@invalid_property.errors.size).to_not equal(0)
      end
    end
  end

end
