class ItemsController < ApplicationController

  def index
  	#@items = [Item.new(title:"Test", description:"Blah")]
    @items = Item.all
  end

  def show
  	id = params[:id]
  	@item = Item.find(id)
  end

  def create
  	#Temp redirect to do nothing!
  	unless params.has_key? :item
  		flash[:error] = "Error creating item: Item details not found"
  		redirect_to new_item_path
  	else
  		item = params[:item]
  		if not item.has_key? :title or item[:title].nil? or item[:title] == ""
  			flash[:error] = "Error creating item: Title must be filled in"
  			flash[:params] = params
  			redirect_to new_item_path
  			return
  		end
  		if not item.has_key? :description or item[:description].nil? or item[:description] == ""
  			flash[:error] = "Error creating item: Description must be filled in"
  			flash[:params] = params
  			redirect_to new_item_path
  			return
  		end

  		#Passed validation, create!
  		tags = item[:tags].gsub(/\s+/, "").split(',')

  		item = Item.create(title: item[:title], description: item[:description], category: item[:category], tags: tags)

  		if item.nil?
  			flash[:error] = "Error creating item: Unable to save"
  			flash[:params] = params
  			redirect_to new_item_path
  			return
  		else
			redirect_to item_path(item.id)
		end
  	end
  end

  def new
  	unless session.has_key? :user
  		flash[:error] = "You need to be logged in to create a new item!"
  		redirect_to sign_in_path
  	else
  		if flash.key? :params and flash[:params].has_key? :item
  			@title = flash[:params][:item][:title] if flash[:params][:item].has_key? :title
  			@description = flash[:params][:item][:description] if flash[:params][:item].has_key? :description
  			@category = flash[:params][:item][:category] if flash[:params][:item].has_key? :category
  			@tags = flash[:params][:item][:tags] if flash[:params][:item].has_key? :tags
  		end
  	end
  end

end
