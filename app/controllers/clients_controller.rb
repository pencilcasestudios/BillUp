class ClientsController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation
  before_filter :membership_required

  def index
    @clients = @current_organisation.clients
  end

  def show
    @client = @current_organisation.clients.find_by_id(params[:id])
  end

  def new
    @client = Client.new
    @client.addresses.build
  end

  # GET /clients/1/edit
  def edit
    @client = @current_organisation.clients.find_by_id(params[:id])
  end

  def create
    @client = Client.new(params[:client])

    if @client.save
      flash[:success] = t('controllers.clients_controller.actions.create.success')
      redirect_to @client
    else
      render action: "new"
    end
  end

  def update
    @client = @current_organisation.clients.find_by_id(params[:id])

    if @client.update_attributes(params[:client])
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render action: "edit"
    end
  end

  #def destroy
  #  @client = @current_organisation.clients.find_by_id(params[:id])
  #  @client.destroy
  #
  #  redirect_to clients_url
  #end
end
