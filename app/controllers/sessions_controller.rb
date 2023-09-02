class SessionsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created

        else
            render json:{error: "unauthorized request"}, status: 401
        end
        
      end
    
      def destroy
        session.delete :user_id
        head :no_content
      end
      private
      def render_not_found 
        render json:{error: "User not found"}, status: 401
      end
end
