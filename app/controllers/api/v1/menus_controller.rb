module Api
  module V1
    class MenusController < ApplicationController
      before_action :set_menu, only: %i(show edit update destroy)

      def create
        @menu = Menu.new(menu_params)

        if @menu.save
          render json: @menu, status: :created
        else
          render json: @menu.errors, status: :unprocessable_entity
        end
      end

      private

      def menu_params
        params.require(:menu).permit(
          :name,
          :user_id # ログインユーザーから取得
        )
      end
    end
  end
end
