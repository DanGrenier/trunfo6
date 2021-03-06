module ControllerMacros
  def login_user
    before (:each) do 
	  @request.env["devise.mapping"] = Devise.mappings[:user]
	  user = create(:user)
	  sign_in user
	  end
  end
  

   def login_admin
   	before (:each) do
   		@request.env["devise.mapping"] = Devise.mappings[:user]
   		user = create(:adminuser)
   		sign_in user
   	end
   end


	def login_invalid
		before (:each) do 
			@request.env["devise.mapping"] = Devise.mappings[:user]
			user = create(:user, password: "blablabla")
			sign_in user
		end
	end

  

end
