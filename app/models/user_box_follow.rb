class UserBoxFollow < ActiveRecord::Base
	attr_accessible :box_id

	belongs_to :user,  class_name: "User"
	belongs_to :box, class_name: "Box"
	
end
