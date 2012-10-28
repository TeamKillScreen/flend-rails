class Item < ActiveResource::Base
  include Gmaps4rails::ActsAsGmappable
  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => false

  self.site = "http://flendapi.azurewebsites.net"
  self.element_name = "items"

  def gmaps4rails_infowindow
  	"<h4><a href='/items/#{self.id}'>#{self.title}</a></h4><p>#{self.description}</p>"
  end

  def gmaps4rails_title
  	self.title
  end
end