class PagesController < ApplicationController

  def home
  end

  def dashboard
  	#If we have some properties setup
  	if any_properties? 
  	  #	But no properties currently selected
      if !property_selected?
      	#Get the user to select one
  		redirect_to properties_path 
  	  #If a property was selected but no rooms	
  	  else
  	  	dashboard_home 
  	  end
  	else
  		first_time_home
  	end

  end

  protected 
    def dashboard_home 
    	render 'dashboard'
    end

    def first_time_home
    	render 'first_time'
    end


end