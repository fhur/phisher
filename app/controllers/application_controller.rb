class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def respond_message(message, code)
    message_obj = { :message => message }
    respond_with json: message_obj, code: code
  end

end
