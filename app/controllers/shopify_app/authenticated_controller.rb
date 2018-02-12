module ShopifyApp
  class AuthenticatedController < ActionController::Base
    include ShopifyApp::Localization
    include ShopifyApp::LoginProtection
    include ShopifyApp::EmbeddedApp

    protect_from_forgery with: :exception
    before_action :login_again_if_different_shop
    around_action :shopify_session

    protected
      def redirect_to_login
        if request.xhr?
          head :unauthorized
        else
          session[:return_to] = request.fullpath if request.get?
          if browser.safari?
            fullpage_redirect_to login_url
          else
            redirect_to login_url
          end
        end
      end
  end
end
