module UsersHelper
    def twitterized_type(type)
      case type
        when :alert
          "alert-block"
        when :error
          "alert-error"
        when :notice
          "alert-info"
        when :success
          "alert-success"
        else
          type.to_s
      end
    end

    def try_to_redirect_back
        begin
            redirect_to :back
        rescue ActionController::RedirectBackError => e
            redirect_to root_path
        end
    end
end
