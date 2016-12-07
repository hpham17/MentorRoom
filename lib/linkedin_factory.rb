class LinkedinFactory

  def self.authorize_user(user)
    client = LinkedIn::Client.new
    client.authorize_from_access(auth.extra.access_token.token, auth.extra.access_token.secret)
    client
  end

  # now every API call would look like this:

  def self.get_profile_picture(user)
    client = self.authorize_user(user)
    user.profile = client.picture_urls.all.first
    user.save
  end

end
