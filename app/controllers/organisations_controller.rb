class OrganisationsController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation, :except => [:new, :create, :index]
  before_filter :membership_required, :except => [:new, :create, :index]

  load_and_authorize_resource
  
  def index
    redirect_to root_url(:host => request.domain)
  end

  def show
    @organisation = @current_organisation
  end

  def new
    @organisation = Organisation.new
    @organisation.addresses.build
  end

  def create
    @organisation = Organisation.new(params[:organisation])
    @organisation.memberships.build(user: current_user)
    if @organisation.save
      flash[:success] = t('controllers.organisations_controller.actions.create.success')
      redirect_to root_url(:host => request.domain)
    else
      render action: "new"
    end
  end

  def edit
    @organisation = @current_organisation
  end

  def update
    @organisation = @current_organisation

    if @organisation.update_attributes(params[:organisation])
      flash[:success] = t('controllers.organisations_controller.actions.update.success')
      redirect_to root_path
    else
      render action: "edit"
    end
  end
end
