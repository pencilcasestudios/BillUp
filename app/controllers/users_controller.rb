class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = t('controllers.users_controller.actions.create.success')
      redirect_to sign_in_path
    else
      render action: "new"
    end
  end
end
