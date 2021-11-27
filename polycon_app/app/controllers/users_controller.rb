class UsersController < ApplicationController
    load_and_authorize_resource
    def index
        @users = User.all.order(:name).paginate(:page => params[:page], :per_page => 10)
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        error_msg = validation(user_params)
        if error_msg.empty? and @user.save
            redirect_to users_path, :alert => "Creación exitosa"
        else
            redirect_to new_user_path, :alert => error_msg
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        error_msg = validation(user_params)
        if error_msg.empty? and @user.update(user_params)
            redirect_to users_path, :alert => "Modificación exitosa"
        else
            redirect_to edit_user_path(@user), :alert => error_msg
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def destroy
        @user = User.find(params[:id])
        @user.delete
        redirect_to users_path, :alert => "Se eliminó el profesional"
    end

    private
        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation, :role)
        end
        
        def validation(user_params)
            error_msg = ""
            if user_params[:password] != user_params[:password_confirmation]
                error_msg = error_msg + "Las contraseñas no coinciden.\n"
            end
            user_aux = User.where(email: user_params[:email])
            if !user_aux.empty?
                error_msg = error_msg + "Ya existe un usuario con este email.\n"
            end
            return error_msg
        end
end