module SessionsHelper  
  
  def set_current_property(property)
    session[:property_id] = property.id 
  end	
  
  def is_current_property?(property)
  	property == current_property 
  end	

  def clear_current_property
  	current_property = nil
  end

  def current_property
  	current_property ||= Property.find(session[:property_id]) if session[:property_id]
  rescue ActiveRecord::RecordNotFound
  	current_property = nil 
  end

  def property_selected?
  	!current_property.nil?
  end

  def any_properties?
  	current_user.properties.count > 0
  end

  def property_count
  	current_user.properties.count
  end

  
end