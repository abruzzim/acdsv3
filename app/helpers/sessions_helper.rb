module SessionsHelper
	# Add the user id to the session.
	def log_in(user)
		session[:user_id] = user.id
	end

	# Returns the current logged-in user, if any.
	def current_user
		# Memoize the current user in an instance variable.
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Returns true if the user is logged in, false otherwise.
	def logged_in?
		!current_user.nil?
	end

	# Delete the user id from the session.
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

end