class OrganisationsController < ApplicationController
  before_filter :sign_in_required

  def new
    @organisation = Organisation.new
  end

  def create
    @organisation = Organisation.new(params[:organisation])
    @organisation.memberships.build(user: current_user)
    if @organisation.save
      flash[:success] = t('controllers.organisations_controller.actions.create.success')
      redirect_to root_path
    else
      render action: "new"
    end
  end
end
