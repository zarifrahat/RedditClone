class ApplicationController < ActionController::Base

    #CELLL
    helper_method :current_user, :logged_in?
    
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def login(user)
        @current_user = user

        session[:session_token] = user.reset_session_token!
    end

    def logged_in?
        !!current_user
    end

    def logout!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def ensure_moderator(user)
        @sub = Sub.find_by(id: params[:id])

        if current_user.id != @sub.user_id
            flash[:errors] = ["You are not the moderator"]
            redirect_to user_url(user)
        end
    end

    def ensure_author(user)
        @post = Post.find_by(id: params[:id])

        if current_user.id != @post.user_id
            flash[:errors] = ["You are not the author!"]
            redirect_to user_url(user)
        end
    end
end
