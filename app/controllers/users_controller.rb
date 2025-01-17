class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
def create 
user = User.create!(user_params)
session[:user_id] = user.id
render json: user, status: :created
end
def show 
    user = User.find(session[:user_id])
    render json: user, status: :ok
end    


private
def render_unprocessable_entity(invalid)
    render json:{errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
end
def user_params 
    params.permit(:username, :password, :password_confirmation)
end
private
      def render_not_found 
        render json:{error: "User not found"}, status: 401
      end
end