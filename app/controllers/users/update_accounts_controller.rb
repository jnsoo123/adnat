module Users
  class UpdateAccountsController < ApplicationController
    def edit
      @user = UserForm.new(user: current_user)
    end

    def update
      @user = UserForm.new(user_params)
      if @user.update
        redirect_to root_path
      else
        render :edit
      end
    end

    private

    def user_params
      params.require(:user)
        .permit(:name, :email, :password, :password_confirmation, :old_password)
        .merge(user_id: current_user.id, user: current_user)
    end
  end
end
