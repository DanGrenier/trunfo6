require "rails_helper"

RSpec.describe "Properties", :type => :request do 
  #Create a user and a property tied to that user
  let!(:user) {create(:user)} 
  let!(:user2) {create(:user, email: 'user@example.com')}
  let!(:property) {create(:property, user: user)}
  let!(:property2) {create(:property, user: user2)}
  

  #Tests to access the different enpoints while user not signed in
  describe 'User Not Signed In' do 
    
    describe 'GET #index' do
      subject { get properties_path} 
      it_behaves_like 'unauthorized_request' 
    end

    describe 'GET #show' do
      subject { get property_path property}
      it_behaves_like 'unauthorized_request' 
    end

    describe 'GET #new' do
      subject {get new_property_path}
      it_behaves_like 'unauthorized_request' 
    end

    describe 'GET #edit' do
      subject {get edit_property_path property} 
      it_behaves_like 'unauthorized_request' 
    end
    
    describe "PATCH #update" do 
      
      subject {patch property_path property, params: {property: attributes_for(:property, user: user, description: "New description")}}

      it "does not update the record in the database" do 
        subject
        expect(property.reload.description).to_not eq "New description"
      end

      it "redirects to sign in page" do 
        subject
        expect(response).to redirect_to (new_user_session_path)
      end
    end


    describe "POST #create" do
      
      subject {post properties_path,params: {property: FactoryBot.attributes_for(:property, user: user) }} 
 
      it "does not change the number of Properties" do 
        expect {subject}.to_not change {Property.count}
      end

      it "redirects to sign in page" do 
        subject
        expect(response).to redirect_to (new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      
      subject {delete property_path property}
 
      it "does not create the property in the database" do 
        expect {subject}.to_not change {Property.count}
      end

      it "redirects to sign in page" do 
        subject
        expect(response).to redirect_to (new_user_session_path)
      end
    end
  end  

  #Tests to access the different enpoints while used signed in
  describe 'User Signed In' do 
    before do 
      sign_in user
    end
    
    describe 'GET #index' do 
      it "returns a successful response" do 
        get properties_path
        expect(response).to be_successful
      end
    end

    describe 'GET #show' do 
      it "returns a successful response" do 
        get property_path property
        expect(response).to be_successful
      end

    end

    describe 'GET #new' do
      it "returns a successful response" do 
        get new_property_path
        expect(response).to be_successful
      end
    end

    describe 'GET #edit' do 
      it "returns a successful response" do 
        get edit_property_path property
        expect(response).to be_successful
      end
    end
    describe "PATCH #update" do 
            
      context "with valid attributes" do 
   
        subject {patch property_path property, params: {property: attributes_for(:property, description: "New description") }}

        it "updates the record in the database" do 
          
          subject
          expect(property.reload.description).to eq "New description"
        end

        it "redirects to properties index" do 
          subject
          expect(response).to redirect_to properties_path
        end
      end

       

      context "with invalid attributes" do
        
        subject {patch property_path property, params: {property: attributes_for(:property,description: nil )}}

        it "does not updates the record in the database" do 
          subject
          expect(property.reload.description).to_not eq nil
        end

        it "returns a successful response" do 
          subject
          expect(response).to be_successful
        end
      end
    end

    describe 'POST #create' do 
      
      context "with valid attributes" do
        subject {post properties_path,params: {property: FactoryBot.attributes_for(:property, :with_picture, user: user) }}
        it "creates a Property in the database" do 
          expect {subject}.to change {Property.count}.by(1)
        end

        it "attaches a picture" do
          expect {subject}.to change(ActiveStorage::Attachment, :count).by(1)
        end

        it "attaches the proper picture" do 
          subject
          expect(Property.last.property_picture.filename.to_s).to eq("home.jpg")
        end

        it "redirects to properties index" do 
          subject
          expect(response).to redirect_to properties_path
        end
      end


      context "with invalid attributes" do
        
        subject {post properties_path,params: {property: FactoryBot.attributes_for(:property, user: user, description: nil) }} 
 
        it "does not creates a Property in the database" do 
          expect {subject}.not_to change {Property.count}
        end  

        it "returns a successful response" do 
          subject
          expect(response).to be_successful
        end 
      end
    end

    describe "DELETE #destroy" do
      subject {delete property_path property}
 
      it "deletes the Property from the database" do 
        expect {subject}.to change {Property.count}.by(-1)
      end

      it "redirects to properties index" do 
        subject
        expect(response).to redirect_to properties_path
      end
    end
  end

  describe "Testing unauthorized access" do 
    
    before do 
      sign_in user2
    end

    describe "GET #show property of another user" do 
      it "should redirect to root" do
        get property_path property
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #edit property of another user" do 
      it "should redirect to root" do 
        get edit_property_path property
        expect(response).to redirect_to root_path
      end
    end 

    describe "PATCH #update property from another user" do 
      subject {patch property_path property, params: {property: attributes_for(:property, description: "New description") }}
      it "should redirect to root" do
        subject      
        expect(response).to redirect_to root_path
      end

      it "should not update the property" do 
        subject
        expect(property.reload.description).not_to eq "New description"
      end
    end

    describe "DELETE #destroy property from another user" do 
      subject {delete property_path property}
      
      it "should redirect to root" do
        subject
        expect(response).to redirect_to root_path
      end

      it "should not delete the property" do 
        expect{subject}.not_to change {Property.count}
      end
    end
  end
end