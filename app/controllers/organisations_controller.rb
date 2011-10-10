class OrganisationsController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation, :except => [:new, :create]
  before_filter :membership_required, :except => [:new, :create]

  def show
    @organisation = current_organisation
  end

  def new
    @organisation = Organisation.new
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
end
