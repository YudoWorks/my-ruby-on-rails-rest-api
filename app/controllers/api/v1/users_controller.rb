# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :find_user, only: %i[show update destroy]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render error: { error: 'Unable to create user.' }, status: 400
        end
      end

      def update
        if @user
          @user.update(user_params)
          render json: { message: 'User successfully updated.' }, status: 200
        else
          render json: { error: 'Unable to update user' }, status: 400
        end
      end

      def destroy
        if @user
          @user.destroy
          render json: { message: 'User successfully deleted.' }, status: 200
        else
          render json: { error: 'Unable to delete user' }, status: 400
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :password)
      end

      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
