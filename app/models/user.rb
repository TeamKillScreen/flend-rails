class User < ActiveResource::Base
  self.site = "http://flendapi.azurewebsites.net"

  def self.login(username, password)
  	begin
  		return User.create(username: username, password: password)
  	rescue ActiveResource::ResourceNotFound => e
  		return nil
  	end
  end
end