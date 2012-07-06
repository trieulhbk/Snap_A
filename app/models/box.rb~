class Box < ActiveRecord::Base
  attr_accessible :name, :user_id
  
  validates :name, presence: true, length: {maximum: 20}

  belongs_to :owner, class_name: "User"

  has_many :user_box_follows, foreign_key: "box_id", 
  dependent: :destroy

  has_many :users, through: :user_box_follows, source: :user

end
