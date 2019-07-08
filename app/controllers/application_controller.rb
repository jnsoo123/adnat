class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  layout :layout_by_resource

  def layout_by_resource
    devise_controller? ? 'devise' : 'application'
  end
end
