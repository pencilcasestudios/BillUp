class UsersController < ApplicationController
  def index
    if current_user
      redirect_to root_url(:subdomain => false)
    else
      redirect_to sign_up_path
    end
  end

  def new
    if current_user
      flash[:notice] = t('controllers.users_controller.actions.new.error')
      redirect_to root_url(:subdomain => false)
    else
      @user = User.new
    end
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
