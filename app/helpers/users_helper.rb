module UsersHelper
    def try_to_redirect_back
        begin
            redirect_to :back
        rescue ActionController::RedirectBackError => e
            redirect_to root_path
        end
    end
end
