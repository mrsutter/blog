class ApplicationController < ActionController::Base
  include AuthHelper
  include FlashHelper

  helper_method :bootstrap_class

  protect_from_forgery with: :exception
end
