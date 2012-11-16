class SessionsController < ApplicationController
  def new
  end

  def create
    #raise request.env['omniauth.auth'].to_yaml
    auth = request.env['omniauth.auth']
    #auth_hash = request.env['omniauth.auth']

    teacher = Teacher.find_by_provider_and_uid(auth['provider'], auth['uid']) || Teacher.create_with_omniauth(auth)
    session[:teacher_id] = teacher.id

=begin
    # First try with omniauth
    if session[:teacher_id]
      # Means our user is signed in. Add the authorization to the user
      Teacher.find(session[:teacher_id]).add_provider(auth_hash)

      #render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)

      # Create the session
      session[:teacher_id] = auth.teacher.id
      session[:teacher] = auth.teacher.name
      #render :text => "Welcome #{auth.teacher.name}!"
    end
=end

    redirect_to root_url, :notice => "Logado com sucesso. Bem-vindo, #{teacher.name}."
  end

  def destroy
    session[:teacher_id] = nil
    session[:teacher] = nil
    #render :text => "You've logged out!"
    redirect_to root_url
  end

  def failure
    #render :text => "Sorry, but you didn't allow access to our app!"
    redirect_to root_url
  end

end
