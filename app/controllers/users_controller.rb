class UsersController < ApplicationController
	include UsersHelper
	def sign_in
		if session.has_key? :user
			#User already logged in, redirect back to where they came from
			try_to_redirect_back
		end

		if params.has_key? :user
			user = params[:user]
			if user.has_key? :username and user.has_key? :password
				user = User.login(user[:username], user[:password])

				unless user.nil?
					session[:user] = user
					flash.keep
					redirect_to root_path
				else
					flash[:error] = "Incorrect username/password."
				end
			end
		end
	end

	def sign_out
		session[:user] = nil
		flash.keep
		try_to_redirect_back
	end

	def show
		unless session.has_key? :user
  		flash[:error] = "You need to be logged in to view your account details!"
  		redirect_to sign_in_path
  		else
  			@user = session[:user]
  		end
	end

	def edit
		unless session.has_key? :user
  		flash[:error] = "You need to be logged in to view your account details!"
  		redirect_to sign_in_path
  		else
  			@user = session[:user]
  		end
	end

	def update
		redirect_to root_path
	end
end
