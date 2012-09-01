class ApplicationController < ActionController::Base
  protected

  def current_teacher
    @current_teacher ||= Teacher.find_by_id(session[:teacher_id])
  end

  def signed_in?
    !!current_teacher
  end

  helper_method :current_teacher, :signed_in?

  def current_teacher=(teacher)
    @current_teacher = teacher
    session[:teacher_id] = teacher.id
  end
end
