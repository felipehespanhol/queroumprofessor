class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    #render :text => auth_hash.inspect

  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorization
    session[:teacher] = @authorization.teacher.name
    #  render :text => "Welcome back #{@authorization.teacher.name}! You have already signed up."
  else @authorization
    #iauth_hash object has => provider,uid,info,credentials,  extra
    teacher = Teacher.new :name => auth_hash["info"]["name"]
    teacher.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    teacher.save

    session[:teacher] = teacher.name

  end

    redirect_to  :controller => "teachers", :action => "home"
  end

  def failure
  end
end
