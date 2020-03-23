require 'rails_helper'

shared_examples_for 'unauthorized_request' do 
  it "returns an unsuccessful response"	do 
  	subject 
  	expect(response).to_not be_successful
  end

  it "redirects to sign in page" do 
  	subject 
  	expect(response).to redirect_to (new_user_session_path)
  end
end
