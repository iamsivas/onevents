class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by(email: params[:login][:email].downcase)
		if user && user.authenticate(params[:login][:password])
			session[:user_id] = user.id.to_s
      if user.name == 'admin'
        session[:user_role] = 1
      else
        session[:user_role] = 2
      end
			redirect_to events_path
			flash[:success] = 'Logged in successfully'
		else
			flash[:error] = "Incorrect email or password, try again."
			render :new
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to root_path
		flash[:success] = "Logged out successfully"
	end
end
