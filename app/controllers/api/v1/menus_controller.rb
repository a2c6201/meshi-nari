module Api
  module V1
    class MenusController < ApplicationController
      before_action :set_user_menu, only: :index

      # GET menu一覧
      def index
        render json: @menus
      end

      def create
        @menu = Menu.new(menu_params)

        if @menu.save
          render json: @menu, status: :created
        else
          render json: @menu.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user_menu
        @menus = Menu.where(user_id: params[:user_id])
      end

      def menu_params
        # :menu から :name を要求し、:user_id は params から直接受け取る
        permitted_params = params.require(:menu).permit(:name)
        permitted_params[:user_id] = params[:user_id]
        permitted_params
      end
    end
  end
end
