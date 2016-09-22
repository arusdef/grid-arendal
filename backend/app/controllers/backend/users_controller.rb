# frozen_string_literal: true
require_dependency "backend/application_controller"

module Backend
  class UsersController < ::Backend::ApplicationController
    load_and_authorize_resource
    before_action :set_user, except: [:index, :new, :create]

    def index
      @users = if current_user&.admin?
                 User.filter_users(user_filters)
               else
                 User.filter_actives
               end
    end

    def show
    end

    def edit
    end

    def new
      @user = User.new
    end

    def update
      if @user.update(user_params)
        redirect_to user_path(@user), notice: 'User updated'
      else
        render :edit
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to users_path
      else
        render :new
      end
    end

    def deactivate
      if @user.try(:deactivate)
        redirect_to users_path
      else
        redirect_to user_path(@user)
      end
    end

    def activate
      if @user.try(:activate)
        redirect_to users_path
      else
        redirect_to user_path(@user)
      end
    end

    def make_admin
      if @user.try(:make_admin)
        redirect_to users_path
      end
    end

    def make_manager
      if @user.try(:make_manager)
        redirect_to users_path
      end
    end

    def make_member
      if @user.try(:make_member)
        redirect_to users_path
      end
    end

    private

      def user_filters
        params.permit(:active)
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit!
      end
  end
end
