class SessionsController < ApplicationController

  def new
  	@page_title = 'Log In'
  end

  def create
  	@page_title = 'Log In'
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user
  	else	
  		flash.now[:danger] = 'Invalid Email/Password'
  		render :new
  	end
  end

  def destroy
  	log_out
  	redirect_to root_path
  end

end
