class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
  def current_user
    @current_user ||= Teacher.find(session[:teacher_id]) if session[:teacher_id]
  end
end
