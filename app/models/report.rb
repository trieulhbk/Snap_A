class Report < ActiveRecord::Base
  attr_accessible :source_id, :target_id, :title

  validates :source_id,presence: true
  validates :target_id,presence: true
  validates :title,presence: true

end
