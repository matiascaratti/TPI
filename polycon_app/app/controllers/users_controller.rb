class UsersController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    def index
        @users = User.all.order(:name)paginate(:page => params[:page], :per_page => 10)
    end
    
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_path, :alert => "Creación exitosa"
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        aux = User.where(email: params[:email])
        if (aux.empty?)
            if @user.update(user_params)
                redirect_to users_path, :alert => "Modificación exitosa"
            else
                render :edit
            end
        else
            render :edit, :alert => "El email ingresado ya existe"
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
end