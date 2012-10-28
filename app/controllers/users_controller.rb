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
		unless params.has_key? :userupdate
	  		flash[:error] = "Error creating userupdate: userupdate details not found"
	  		redirect_to new_userupdate_path
	  	else
	  		userupdate = params[:userupdate]
	  		if not userupdate.has_key? :firstname or userupdate[:firstname].nil? or userupdate[:firstname] == ""
	  			flash[:error] = "Error updating user: Firstname must be filled in"
	  			flash[:params] = params
	  			redirect_to my_account_edit_path
	  			return
	  		end
	  		if not userupdate.has_key? :surname or userupdate[:surname].nil? or userupdate[:surname] == ""
	  			flash[:error] = "Error updating user: Surname must be filled in"
	  			flash[:params] = params
	  			redirect_to my_account_edit_path
	  			return
	  		end

	  		if not userupdate.has_key? :postcode or userupdate[:postcode].nil? or userupdate[:postcode] == ""
	  			flash[:error] = "Error updating user: Postcode must be filled in"
	  			flash[:params] = params
	  			redirect_to my_account_edit_path
	  			return
	  		elsif not userupdate[:postcode].match /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\ [0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$/
	  			flash[:error] = "Error updating user: Please enter a valid postcode."
	  			flash[:params] = params
	  			redirect_to my_account_edit_path
	  			return
	  		end

	  		if not userupdate.has_key? :mobnumber or userupdate[:mobnumber].nil? or userupdate[:mobnumber] == ""
	  			flash[:error] = "Error updating user: Mobile Number must be filled in"
	  			flash[:params] = params
	  			redirect_to my_account_edit_path
	  			return
	  		end

	  		user = session[:user]

	  		user.firstName = userupdate[:firstname]
	  		user.lastName = userupdate[:surname]
	  		user.postcode = userupdate[:postcode]
	  		user.mobileNumber = userupdate[:mobnumber]

	  		user.save

	  		flash[:success] = "Details Updated"
			redirect_to my_account_path
		end

	end
end
