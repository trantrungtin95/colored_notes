class ApplicationController < ActionController::Base
    before_action :authorize
    before_action :changed_password

    protected
    def authorize
        @current_user = User.find_by(id: session[:user_id]) 
        if @current_user == nil
            redirect_to '/login', :notice => 'You must login first'
        end
    end

    def changed_password
        @current_user = User.find_by(id: session[:user_id]) 
        if @current_user.changed_password == "false"
            redirect_to edit_user_path(@current_user), :notice => 'You must update your account information!'
        end
    end
    


    def current_user
      @current_user
    end
    helper_method :current_user
end
