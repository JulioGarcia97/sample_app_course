class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :delete]
	before_action :logged_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]
	def new
		@user = User.new
		@page_title = 'Sign Up'
	end

	def show
		@page_title = @user.name
	end

	def create
		@page_title = 'Sign Up'
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = 'Bienvenido a Sample App!'
			redirect_to @user
		else
			render :new
		end
	end

	def edit
		@page_title = 'Edit Account'
	end

	def update
		@page_title = 'Edit Account'
		if @user.update(user_params)
			flash[:success] = 'Se actualizo correctamente tu perfil'
			redirect_to @user
		else
			render :edit
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = 'Necesitas tener cuenta para acceder a esa pagina'
			redirect_to login_path
		end
	end 

	def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
