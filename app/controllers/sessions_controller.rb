class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :changed_password

  def new
  end

  def create
    # 
    if user = User.authenticate(params[:name], params[:password])
      # Check if user update new password for the first time
      # field: changed_password (User). It's true, when the user is created manually
      # If it's invited, it's false.
      # if user doesn't update password, redirects to change password page.
      # last sign in of user
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to sessions_new_path, :alert => "Invalid username/password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path, :notice => "Logged out"
  end
end
