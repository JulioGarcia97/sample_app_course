class UsersController < ApplicationController

	def new
		@user = User.new
		@page_title = 'Sign Up'
	end

	def show
		@user = User.find(params[:id])
		@page_title = @user.name
	end

	def create
		@page_title = 'Sign Up'
		@user = User.new(user_params)
		if @user.save
			flash[:success] = 'Bienvenido a Sample App!'
			redirect_to @user
		else
			render :new
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
