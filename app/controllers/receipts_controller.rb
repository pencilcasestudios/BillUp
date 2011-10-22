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
    # The view finds all addresses associated to all the clients of this organisation:
    # Ref: http://stackoverflow.com/questions/7211846/rails-nested-has-many-association-finding-all-children

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
end
