class InvitationsController < ApplicationController
  before_filter :signed_in_user, only: [:facebook, :twitter]
  before_filter :signed_in_facebook, only: [:facebook]
  before_filter :signed_in_twitter, only: [:twitter]

  def index
  end
  def facebook
  end
  def twitter
  end
  def mail
  end
end
