class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Handle CanCan authorization failures
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to articles_path, alert: exception.message
  end
end
