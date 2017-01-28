class UserController < ApplicationController
    def login
        @user = User.new

        if request.post?
            @user = User.new(user_params)
            if @user.valid? == false
                render 'login'
            else
                session[:authorized] = true
                redirect_to root_path
            end
        end

    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end
