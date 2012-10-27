class ItemsController < ApplicationController

  def index
  	#@items = [Item.new(title:"Test", description:"Blah")]
    @items = Item.all
  end

end
