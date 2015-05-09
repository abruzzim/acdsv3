class SessionsController < ApplicationController

  def new
  end

  def create
  	# Find the user by submitted email address.
  	user = User.find_by(email: params[:session][:email].downcase)
  	# If the user exists and submits a valid password...
  	if user && user.authenticate(params[:session][:password])
  		#...then log the user in,
  		log_in user
  		# and redirect to the user's show page;
  		redirect_to user
  	else
  		#...else display a temp error message,
  		flash.now[:danger] = "%SESSIONS_CONTROLLER-E-INVALID, Invalid email/password combination."
  		# and re-render the new view.
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end

end
