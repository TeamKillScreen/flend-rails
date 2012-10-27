class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :user_logged_in?

  def user_logged_in?
  	if session.has_key? :user
  		@welcome_message = "Welcome #{session[:user].firstName}!"
  		@signed_in = true
  	else
  		@welcome_message = nil
  		@signed_in = false
  	end
  end
end
