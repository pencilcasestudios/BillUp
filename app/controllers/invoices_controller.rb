class InvoicesController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation
  before_filter :membership_required

  def index
    @invoices = @current_organisation.invoices
  end

  def new
    @invoice = Invoice.new
    @invoice.due_at = Time.now + 4.weeks    
    @invoice.from = @current_organisation.name
    @invoice.from_address = @current_organisation.current_address
    @invoice.uuid = `uuidgen`.strip.downcase
    #@invoice.line_items.build

    if @current_organisation.invoices.blank?
      @invoice.invoice_number = 1
    else
      @invoice.invoice_number = @current_organisation.invoices.first.invoice_number + 1
    end
  end
end
