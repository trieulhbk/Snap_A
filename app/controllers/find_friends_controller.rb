class FindFriendsController < ApplicationController
  include SessionsHelper
  before_filter :signed_in_user, only: [:find_facebook]
  before_filter :signed_in_facebook, only: [:find_facebook]

  def index
  end
 
  def show
  end

  def find_facebook
    authentication = current_user.authentications.find_by_provider('facebook')
    token = authentication.access_token
    me = FbGraph::User.me(token)
    friends_id = me.friends.map(&:raw_attributes).map{|f| f['id']}
    friends_auth = Authentication.where('provider = "facebook" AND uid in (?)', friends_id)
    @friends_profile = friends_auth.map{|f| f.user if f.user.active?}
  end
end
