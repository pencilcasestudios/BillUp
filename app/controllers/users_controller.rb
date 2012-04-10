class UsersController < ApplicationController
  before_filter :sign_in_required, :except => [:new, :create]
  before_filter :sign_out_required, :only => [:new, :create]

  load_and_authorize_resource

  def index
    redirect_to root_url(host: request.domain)
  end
  
  def show
    redirect_to account_settings_path
  end

  def new
    if current_user
      flash[:notice] = t("controllers.users_controller.actions.new.error")
      redirect_to root_url(host: request.domain)
    else
      #@user = User.new
      # Do nothing
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save_with_captcha
      Emailer.delay.registration_confirmation(@user)
      flash[:success] = t("controllers.users_controller.actions.create.success")
      redirect_to sign_in_path
    else
      render action: "new"
    end
  end

  def edit
    if @user.blank?
      @user = current_user
    end
  end

  def update
    if @user.blank?
      @user = current_user
    end
    if @user.update_attributes(params[:user])
      redirect_to(account_settings_path, notice: t("controllers.users_controller.actions.update.success"))
    else
      render action: "edit"
    end
  end
end
