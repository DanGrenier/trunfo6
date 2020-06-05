class Property < ApplicationRecord
  belongs_to :user
  has_one_attached :property_picture	
  validates_presence_of :description
  validate :check_image_type 

  attr_accessor :remove_picture

  after_save :purge_picture, if: :purge_requested?


  def thumbnail 
    if property_picture
      return self.property_picture.variant(resize_to_limit: [150, 150])
      
    else
      return nil
    end
  end

  private

  def check_image_type
  	if property_picture.attached? && !property_picture.content_type.in?(%("image/jpeg image/png image/jpg"))
       errors.add(:property_picture, I18n.t("activerecord.errors.models.property.attributes.property_picture.invalid_format"))	
      return false
   	end
  end

  def purge_requested?
  	remove_picture == "1"
  end

  def purge_picture
  	property_picture.purge_later
  end


end