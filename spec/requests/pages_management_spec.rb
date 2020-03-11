require "rails_helper"


RSpec.describe "Pages Management", :type => :request do 
  
  describe 'User Not Signed In' do 
    describe 'GET #root' do 
      it "returns a successful response" do 
  	    get root_path
  	    expect(response).to be_successful
  	  end

  	  it "shows the login info" do 
  	    get root_path
  	    expect(response.body).to include("Welcome")	
  	  end
    end

    describe 'GET #about' do 
      it "returns a successful response" do 
        get about_path
        expect(response).to be_successful
      end

      it "shows the about page" do 
        get about_path
        expect(response.body).to include("shoebox")
      end
    end
  end  

  describe 'User Signed In' do 
    before do 
      user = create(:user)
      sign_in user
    end

    describe 'GET #root' do 
      it "returns a successful response" do 
        get root_path
        expect(response).to be_successful
      end
      
      it "does not show the login info" do 
        get root_path
        expect(response.body).to_not include("Welcome") 
      end

      it "shows the proper menu" do 
        get root_path
        expect(response.body).to include("My Account") 
      end
    end

    describe 'GET #about' do 
      it "returns a successful response" do 
        get about_path
        expect(response).to be_successful
      end

      it "shows the about page" do 
        get about_path
        expect(response.body).to include("shoebox")
      end
    end


  end

end