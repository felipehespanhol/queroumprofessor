class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    #render :text => auth_hash.inspect

  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorization
    render :text => "Welcome back #{@authorization.teacher.name}! You have already signed up."
  else
    #20.times {puts "\n"}
    #teacher = Teacher.new :name => auth_hash["user_info"]["name"], :email => auth_hash["user_info"]["email"]
    teacher = Teacher.new :name => auth_hash["name"], :email => auth_hash["email"]
    teacher.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    teacher.save

    render "teachers/home"
    #render :text => "Hi #{teacher.name}! You've signed up."
  end

  end

  def failure
  end
end
