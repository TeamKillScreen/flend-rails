class Item < ActiveResource::Base
  include Gmaps4rails::ActsAsGmappable
  acts_as_gmappable :lat => 'lat', :lng => 'lng', :process_geocoding => false

  self.site = "http://flendapi.azurewebsites.net"
  self.element_name = "items"
end