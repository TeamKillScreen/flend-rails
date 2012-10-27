class Item < ActiveResource::Base
  self.site = "http://flendapi.azurewebsites.net"
  self.element_name = "items"
end