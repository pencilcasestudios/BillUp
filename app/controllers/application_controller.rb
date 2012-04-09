class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with name: AppConfig.http_basic_name, password: AppConfig.http_basic_password unless Rails.env == "test"

  check_authorization # CanCan Ref: https://github.com/ryanb/cancan/wiki/Ensure-Authorization

  helper_method :current_user, :user_signed_in?, :current_organisation

  before_filter :set_user_time_zone

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t("controllers.application_controller.flash.access_denied")
    redirect_to root_path
  end

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user.present?
  end
  
  def membership_required
    if @current_organisation.members.exists?(id: current_user.id)
      # The current user can access this Organisation
      # Do nothing
    else
      # The current user is not allowed to access this Organisation
      flash[:error] = t('controllers.application_controller.flash.membership_required')
      redirect_to root_url(:host => request.domain)
    end
  end

  def sign_in_required
    unless current_user
      store_location
      flash[:notice] = t('controllers.application_controller.flash.sign_in_required')
      redirect_to sign_in_path
      return false
    end
  end

  def sign_out_required
    if current_user
      #store_location
      flash[:warning] = t("controllers.application_controller.flash.sign_out_required")
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] =
    if request.get?
      request.fullpath
    else
      request.referer
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end
  
  def current_organisation
    @current_organisation ||= Organisation.find_by_subdomain(request.subdomain) || resource_not_found
  end

  def resource_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
