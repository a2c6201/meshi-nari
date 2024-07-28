module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i(show destroy)

      # GET user一覧
      def index
        @users = User.all
        render json: @users
      end

      # GET /users/1 or /users/1.json
      def show; end

      # POST /users or /users.json
      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1 or /users/1.json
      def destroy
        @user.destroy!
        render json: { message: 'User deleted successfully' }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
