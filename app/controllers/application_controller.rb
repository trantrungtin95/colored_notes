class ApplicationController < ActionController::Base
    before_action :authorize

    protected
    def authorize
        @current_user = User.find_by(id: session[:user_id]) 
        if @current_user == nil
            redirect_to '/login', :notice => 'You must login first'
        end
    end


    def current_user
      @current_user
    end
    helper_method :current_user
end
