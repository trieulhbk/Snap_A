class Authentication < ActiveRecord::Base
  attr_accessible :access_token, :provider, :uid, :user_id, :token_secret
  belongs_to :user 
  validates :uid, :provider, :presence => true
  validates_uniqueness_of :uid, :scope => :provider
end
