class SessionsController < ApplicationController
  def new
  end
=begin
  def create
    auth_hash = request.env['omniauth.auth']
    #render :text => auth_hash.inspect

  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorization
    session[:teacher] = @authorization.teacher.name #  render :text => "Welcome back #{@authorization.teacher.name}! You have already signed up."
  else
    #iauth_hash object has => provider,uid,info,credentials,  extra
    teacher = Teacher.new :name => auth_hash["info"]["name"]
    teacher.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    teacher.save

    session[:teacher] = teacher.name

  end

    redirect_to  :controller => "teachers", :action => "home"
  end
=end
  def create
    auth_hash = request.env['omniauth.auth']

    if session[:teacher_id]
      # Means our user is signed in. Add the authorization to the user
      Teacher.find(session[:teacher_id]).add_provider(auth_hash)

      #render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)

      # Create the session
      session[:teacher_id] = auth.teacher.id

      #render :text => "Welcome #{auth.teacher.name}!"
    end

    redirect_to  :controller => "teachers", :action => "home"
  end

  def destroy
    session[:teacher_id] = nil
    render :text => "You've logged out!"
  end

  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end

end
