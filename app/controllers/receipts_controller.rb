class ReceiptsController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation
  before_filter :membership_required

  def new
    # The view finds all addresses associated to all the clients of this organisation:
    # Ref: http://stackoverflow.com/questions/7211846/rails-nested-has-many-association-finding-all-children

    @receipt = Receipt.new
    @receipt.from = @current_organisation.name
    @receipt.from_address = @current_organisation.current_address
    @receipt.uuid = `uuidgen`.strip.downcase
    
    if @current_organisation.receipts.blank?
      @receipt.receipt_number = 1
    else
      @receipt.receipt_number = @current_organisation.receipts.first.receipt_number + 1
    end
  end

end
