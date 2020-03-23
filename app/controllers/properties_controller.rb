class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :assign_property, only: [:show, :edit, :update, :destroy]	
  before_action :access_restriction, only:[:show, :edit, :update, :destroy]

  def index
  	@properties = current_user.properties
  end

  def show
  end

  def new
    @property = current_user.properties.new
  end

  def create
  	@property = current_user.properties.new(property_params)
  	if @property.save
  	  flash[:success] = I18n.t :property_saved_success
  	  redirect_to properties_path
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	@property.assign_attributes(property_params)
  	if @property.save 
  	  flash[:success] = I18n.t :property_updated_success
      redirect_to properties_path
  	else
  	  render :edit
    end
  end

  def destroy
  	#If we destroy the currently selected property
  	#we need to reset it
  	is_current = is_current_property?(@property)
  	if @property.destroy
  		flash[:success] = I18n.t :property_deleted_success
  		clear_current_property if is_current
  		redirect_to properties_path
  	else
  		flash[:danger] = I18n.t :property_deleted_failure
  	end
  end

  def select
    property = Property.find(params[:id])
    set_current_property(property)
    redirect_to root_path
  end

  private
    def property_params
      params.require(:property)
      .permit(:description, :address, :address2,
      	      :city, :state, :zip)
    end

    def assign_property
      @property = Property.find(params[:id])
    end

    def access_restriction
      redirect_to(root_path, flash: {danger: (I18n.t :unauthorized_access_resource)}) unless(@property.user == current_user)	
    end


end