class StaticPagesController < ApplicationController

	def home
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'home' called."
	end

	def asthmaticus
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'asthmaticus' called."
	end

	def dka
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'dka' called."
	end

	def epilepticus
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'epilepticus' called."
	end

	def sepsis
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'sepsis' called."
	end

	def tbi
		puts "%STATIC_PAGES_CONTROLLER-I-TRACE, 'tbi' called."
	end
	
end