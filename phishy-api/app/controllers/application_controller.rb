class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def respond_message(message:nil, status: nil)
    message_obj = { :message => message }
    render :json => message_obj, :status => status
  end

end
