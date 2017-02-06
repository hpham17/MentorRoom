# Warden::Manager.after_set_user do |user,auth,opts|
#   scope = opts[:scope]
#   auth.cookies.signed["#{scope}.id"] = user.id
#   auth.cookies.signed["#{scope}.expires_at"] = 30.minutes.from_now
# end
#
# Warden::Manager.before_logout do |user, auth, opts|
#   scope = opts[:scope]
#   auth.cookies.signed["#{scope}.id"] = nil
#   auth.cookies.signed["#{scope}.expires_at"] = nil
#   user.current_sign_in_at = nil
#   user.save
# end
