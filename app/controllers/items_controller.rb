class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
  	id = params[:id]
  	@item = Item.find(id)
  	categories = Category.all
  	catindex = categories.index { |x| x.id == @item.category }
  	if catindex.nil?
  		@category = "Unknown"
  	else
  		@category = categories[catindex].description
  	end

  	#Map details
  	@json = @item.to_gmaps4rails
  end

  def create
  	unless session.has_key? :user
  		flash[:error] = "You need to be logged in to create a new item!"
  		redirect_to sign_in_path
  	else
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

	  		if not item.has_key? :postcode or item[:postcode].nil? or item[:postcode] == ""
	  			flash[:error] = "Error creating item: Item Location must be filled in"
	  			flash[:params] = params
	  			redirect_to new_item_path
	  			return
	  		elsif not item[:postcode].match /^([A-PR-UWYZ]([0-9]{1,2}|([A-HK-Y][0-9]|[A-HK-Y][0-9]([0-9]|[ABEHMNPRV-Y]))|[0-9][A-HJKS-UW])\ [0-9][ABD-HJLNP-UW-Z]{2}|(GIR\ 0AA)|(SAN\ TA1)|(BFPO\ (C\/O\ )?[0-9]{1,4})|((ASCN|BBND|[BFS]IQQ|PCRN|STHL|TDCU|TKCA)\ 1ZZ))$/
	  			flash[:error] = "Error creating item: Please enter a valid postcode."
	  			flash[:params] = params
	  			redirect_to new_item_path
	  			return
	  		end

	  		#Passed validation, create!
	  		tags = item[:tags].gsub(/\s+/, "").split(',')

	  		user = session[:user]

	  		item = Item.create(title: item[:title], description: item[:description], category: item[:category], tags: tags, postcode: item[:postcode], userId: user.id)

	  		if item.nil?
	  			flash[:error] = "Error creating item: Unable to save"
	  			flash[:params] = params
	  			redirect_to new_item_path
	  			return
	  		else
	  			flash[:success] = "Item created successfully!"
				redirect_to item_path(item.id)
			end
		end
  	end
  end

  def new
  	unless session.has_key? :user
  		flash[:error] = "You need to be logged in to create a new item!"
  		redirect_to sign_in_path
  	else
  		@categories = Category.all

  		if flash.key? :params and flash[:params].has_key? :item
  			@title = flash[:params][:item][:title] if flash[:params][:item].has_key? :title
  			@description = flash[:params][:item][:description] if flash[:params][:item].has_key? :description
  			@category = flash[:params][:item][:category] if flash[:params][:item].has_key? :category
  			@tags = flash[:params][:item][:tags] if flash[:params][:item].has_key? :tags
  			@postcode = flash[:params][:item][:postcode] if flash[:params][:item].has_key? :postcode
  		end
  	end
  end

end
