class SessionsController < ApplicationController

  def new
		puts "%SESSIONS_CONTROLLER-I-TRACE, new called." 
  end

  def create
		puts "%SESSIONS_CONTROLLER-I-TRACE, create called." 
  	# Find the user by submitted email address.
  	user = User.find_by(email: params[:session][:email].downcase)
  	# If the user exists and submits a valid password...
  	if user && user.authenticate(params[:session][:password])
  		#...then log the user in,
  		log_in user
  		#...and remember the logged in user,
  		remember user
  		# and redirect to the user's show page;
  		redirect_to root_url
  	else
  		#...else display a temp error message,
  		flash.now[:danger] = "%SESSIONS_CONTROLLER-E-INVALID, Invalid email/password combination."
  		# and re-render the new view.
  		render 'new'
  	end
  end

  def destroy
		puts "%SESSIONS_CONTROLLER-I-TRACE, destroy called." 
  	log_out if logged_in?
  	redirect_to root_url
  end

end
