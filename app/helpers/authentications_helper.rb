module AuthenticationsHelper
  def twitter(user)
    authentication = user.authentications.find_by_provider('twitter')
    token = authentication.access_token
    token_secret = authentication.token_secret
    Twitter.configure do |config|
      config.consumer_key = TWITTER_APP_ID
      config.consumer_secret = TWITTER_SECRET
      config.oauth_token = token
      config.oauth_token_secret = token_secret
    end
    twitter = Twitter
  end
end
