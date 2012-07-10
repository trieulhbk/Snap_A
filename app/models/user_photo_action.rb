class UserPhotoAction < ActiveRecord::Base
  attr_accessible :action, :photo_id, :user_id

  belongs_to :user
  belongs_to :photo
end
