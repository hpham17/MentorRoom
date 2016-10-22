Warden::Manager.before_logout do |user, auth, opts|
  user.current_sign_in_at = nil
  user.save
end
