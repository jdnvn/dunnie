module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :current_user
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.find_by(id: session[:user_id])
  end
end
