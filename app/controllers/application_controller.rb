class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :user_logged_in?

  def user_logged_in?
  	if session.has_key? :user
  		@welcome_message = "Welcome #{session[:user].firstName}!"
  		@sign_in = false
  	else
  		@welcome_message = nil
  		@sign_in = true
  	end
  end
end
