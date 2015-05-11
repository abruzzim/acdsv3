module ApplicationHelper
	# Return the full title on a per-page basis.
	def full_title(page_title = '') 		# Method def, optional arg
		base_title = "ACDS" 							# Variable assignment
		if page_title.empty? 							# Boolean test
			base_title 											# Implicit return
		else
			"#{page_title} | #{base_title}" # String interpolation
		end
	end
end
