class ReceiptsController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation
  before_filter :membership_required

  def index
    @receipts = @current_organisation.receipts
  end

  def show
    @receipt = @current_organisation.receipts.find_by_id(params[:id])
  end

  def new
    @client = @current_organisation.clients.find_by_id(params[:client_id]) if params[:client_id]
    if @client.present?
      @client_addresses = @client.addresses
    else
      # Finds all addresses associated to all the clients of this organisation:
      # Ref: http://stackoverflow.com/questions/7211846/rails-nested-has-many-association-finding-all-children
      @client_addresses = @current_organisation.clients.map(&:addresses).flatten
    end

    @receipt = Receipt.new
    @receipt.uuid = `uuidgen`.strip.downcase
    
    if @current_organisation.receipts.blank?
      @receipt.receipt_number = 1
    else
      @receipt.receipt_number = @current_organisation.receipts.first.receipt_number + 1
    end
  end

  def create
    @receipt = Receipt.new(params[:receipt])
    @receipt.organisation = @current_organisation
    @receipt.client = Address.find_by_id(params[:receipt][:from_address_id]).addressable if params[:receipt][:from_address_id].present?

    if @receipt.save
      flash[:success] = t("controllers.receipts_controller.actions.create.success")
      redirect_to @receipt
    else
      render action: "new"
    end
  end

  def edit
    @receipt = @current_organisation.receipts.find_by_id(params[:id])
  end

  def update
    @receipt = @current_organisation.receipts.find_by_id(params[:id])

    if @receipt.update_attributes(params[:receipt])
      flash[:success] = t('controllers.receipts_controller.actions.update.success')
      redirect_to @receipt
    else
      render action: "edit"
    end
  end
end
