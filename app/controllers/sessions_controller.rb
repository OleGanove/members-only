class SessionsController < ApplicationController
  def new
  end

  def create

    # Using the form sessions/new.html.erb -> params hash is constructed, 
    # containing email and password under the session key. Retrieve by: 
  	user = User.find_by(email: params[:session][:email].downcase)

    # if user is in database and user typed in correct password: 
  	if user && user.authenticate(params[:session][:password])
      flash[:success] = "Thank you for signing in" 
      #uses sign_in method in sessions_helper.rb (included in ApplicationController)
  	  sign_in user     
      redirect_to root_path
  	else    
      flash.now[:error] = "Wrong email or password"                                             
  	  render "new"
  	end
  end

  def destroy
    #uses sign_out method in sessions_helper.rb (included in ApplicationController)
    flash[:success] = "You have been signed out"
    sign_out
    redirect_to root_path
  end
end
