class SessionsController < ApplicationController
  # user shouldn't have to be logged in before logging in!
  skip_before_filter :set_current_user

  def create
    auth = request.env['omniauth.auth']
 
    if @current_user #session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth)
 
      render :text => "You can now login using #{auth_hash["provider"].capitalize} too!" #TODO
    else
      # Log in or sign up
      identity = Identity.find_or_create(auth)
 
      # Create the session
      session[:user_id] = identity.user.id
 
      render :text => "Welcome #{identity.user.name}!"
      #TODO 
      #redirect_to expenses_path
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to expenses_path
  end
end