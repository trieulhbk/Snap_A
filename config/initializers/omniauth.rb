Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, GRAPH_APP_ID, GRAPH_SECRET, {:scope => 'email, user_photos, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
 
  # If you want to also configure for additional login services, they would be configured here.
end