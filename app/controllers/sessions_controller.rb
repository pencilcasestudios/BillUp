class SessionsController < ApplicationController
  def index
    if current_user
      redirect_to root_path
    else
      redirect_to sign_in_path
    end
  end
  
  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    # Authenticate with username, email or cell_phone_number
    user = User.find_by_email(params[:identifier]) || User.find_by_username(params[:identifier]) || User.find_by_cell_phone_number(params[:identifier])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = t('controllers.sessions_controller.actions.create.success')
      redirect_back_or_default root_path
    else
      flash.now[:error] = t('controllers.sessions_controller.actions.create.error')
      render "new"
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      flash[:success] =  t('controllers.sessions_controller.actions.destroy.success')
    end
    redirect_to sign_in_path
  end

end
