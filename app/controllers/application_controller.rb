class ApplicationController < ActionController::Base
  include FlashHelper

  protect_from_forgery with: :exception
end
