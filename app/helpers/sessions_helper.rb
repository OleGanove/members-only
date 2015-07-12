module SessionsHelper
  def sign_in(user) 
  	# create a new token
    remember_token = User.new_remember_token	

    # save the new token in a browser's cookie
    cookies.permanent[:remember_token] = remember_token 

    # update database with new token (update_attribute -> can surpass the validation
    # since we don't have user's password or confirmation here!)
    user.update_attribute(:remember_token, User.digest(remember_token)) 	
    self.current_user = user
  end

  # in order to retrieve the current user (e.g. put it in controller or view)
  # we need to create a "set current_user" method

  def current_user=(user)
  	@current_user = user
  end						

  def current_user
  	remember_token = User.digest(cookies[:remember_token])
  	@current_user ||= User.find_by(remember_token: remember_token)
  end

  # a user is signed in if there is a current user in the session (if current_user is not nil)
  def signed_in?
  	!current_user.nil?
  end

  def sign_out
  	# change the user's remember token in the database (in case it could be stolen)
  	current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
  	cookies.delete(:remember_token)
  	self.current_user = nil
  end
end
