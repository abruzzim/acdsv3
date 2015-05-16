module SessionsHelper

	# Add the user id to the session.
	#
	def log_in(user)
		puts "%SESSIONS_HELPER-I-TRACE, log_in called." 
		session[:user_id] = user.id
	end

	# Delete the user id from the session.
	#
	def log_out
		puts "%SESSIONS_HELPER-I-TRACE, log_out called." 
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# Stores a securely encrypted (signed) user id
	# paired with a permanent remember token.
	#
	def remember(user)
		puts "%SESSIONS_HELPER-I-TRACE, remember called." 
		# Generate a hashed, URL-safe, base64, 22-character remember token.
		user.remember
		# Store the user id in a permanent, securely-encrypted (signed) cookie.
		cookies.permanent.signed[:user_id] = user.id
		# Store the remember token in a permanent, securely-encrypted (signed) cookie.
		cookies.permanent[:remember_token] = user.remember_token
	end

	# Forgets a persistent session.
	#
	def forget(user)
		puts "%SESSIONS_HELPER-I-TRACE, forget called." 
		# Nullify the remember digest.
		user.forget
		# Delete the user id from the permanent cookie.
		cookies.delete(:user_id)
		# Delete the remember token from the permanent cookie.
		cookies.delete(:remember_token)
	end

	# Returns the current logged-in user, if any.
	#
	def current_user
		puts "%SESSIONS_HELPER-I-TRACE, current_user called." 
		# If a session of the user id exists, while setting user_id to session of user_id...
		if (user_id = session[:user_id])
			# ...then memoize the current user in an instance variable.
			@current_user ||= User.find_by(id: session[:user_id])
		# ...else if a signed cookie of user id exists, while setting user_id to signed cookie of user_id...
		elsif (user_id = cookies.signed[:user_id])
			# ...then find the user in the database,
			user = User.find_by(id: user_id)
			# If the user exists and the remember token matches the digest...
			if (user && user.authenticated?(cookies[:remember_token]))
				# ... then log the user in,
				log_in user
				# ...and memoize the current user in an instance variable.
				@current_user = user
			end
		end
	end

	# Returns true if the user is logged in, false otherwise.
	#
	def logged_in?
		puts "%SESSIONS_HELPER-I-TRACE, logged_in? called." 
		!current_user.nil?
	end

end