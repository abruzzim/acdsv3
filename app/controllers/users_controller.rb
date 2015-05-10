class UsersController < ApplicationController

  def new
  	puts "%USERS_CONTROLLER-I-TRACE, new called."
  	@user = User.new
  end

	def create
  	puts "%USERS_CONTROLLER-I-TRACE, create called."
		# Use Rails 4 strong parameters feature to prevent cross-site request forgery.
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Welcome to the Advanced Clinical Decision Support Website!"
			redirect_to user_url(@user)
		else
			render 'new'
		end
	end

  def show
  	puts "%USERS_CONTROLLER-I-TRACE, show called."
  	@user = User.find(params[:id])
  end

	private

		def user_params
  		puts "%USERS_CONTROLLER-I-TRACE, user_params called."
			# Specify which parameters are required and permitted.
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

end
