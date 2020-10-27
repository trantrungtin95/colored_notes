class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
    else
      redirect_to sessions_new_path, :alert => "Invalid username/password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path, :notice => "Logged out"
  end
end
