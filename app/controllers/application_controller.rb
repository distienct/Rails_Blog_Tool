class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :find_category

  def authenticate_user!
    redirect_to new_session_path, notice: "Please login first" unless current_user.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method :current_user

  def find_category
    @categories = Category.all
    sdfsdf
      test    
  end
end
