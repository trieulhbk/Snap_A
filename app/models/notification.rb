class Notification < ActiveRecord::Base
  attr_accessible :source_id, :target_id, :relation_type

  validates :source_id,presence: true
  validates :target_id,presence: true
  validates :relation_type,presence: true
end
