class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end

  def dashboard
  	unless session.has_key? :user
  		flash[:error] = "You need to be logged in to view your dashboard!"
  		redirect_to sign_in_path
  	else
  		@items = Item.all
  		@user = session[:user]

  		@json = @items.to_gmaps4rails
  	end
  end
end
