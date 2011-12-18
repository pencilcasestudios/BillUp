class UsersController < ApplicationController
  before_filter :sign_in_required, except: [:new, :create]

  def index
    redirect_to root_url(host: request.domain)
  end

  def new
    if current_user
      flash[:notice] = t("controllers.users_controller.actions.new.error")
      redirect_to root_url(host: request.domain)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      Emailer.delay.registration_confirmation(@user)
      flash[:success] = t("controllers.users_controller.actions.create.success")
      redirect_to sign_in_path
    else
      render action: "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to(account_settings_path, notice: t("controllers.users_controller.actions.update.success"))
    else
      render action: "edit"
    end
  end
end
