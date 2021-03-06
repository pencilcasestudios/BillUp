class SessionsController < ApplicationController
  skip_authorization_check

  before_filter :sign_out_required, :except => [:destroy]
  before_filter :sign_in_required, :only => [:destroy]

  def index
    redirect_to sign_in_path
  end
  
  def new
  end

  def create
    # Authenticate with username, email or cell_phone_number
    user = User.find_by_email(params[:identifier]) || User.find_by_username(params[:identifier]) || User.find_by_cell_phone_number(params[:identifier])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = t("controllers.sessions_controller.actions.create.success")
      redirect_back_or_default root_path #root_url(:host => request.domain)
    else
      flash.now[:error] = t("controllers.sessions_controller.actions.create.error")
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] =  t("controllers.sessions_controller.actions.destroy.success")
    redirect_to sign_in_path
  end
end
