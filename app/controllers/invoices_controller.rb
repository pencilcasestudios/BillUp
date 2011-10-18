class InvoicesController < ApplicationController
  before_filter :sign_in_required
  before_filter :current_organisation
  before_filter :membership_required

  def index
    @invoices = @current_organisation.invoices
  end

  def show
    @invoice = @current_organisation.invoices.find_by_id(params[:id])
  end

  def new
    # The view finds all addresses associated to all the clients of this organisation:
    # Ref: http://stackoverflow.com/questions/7211846/rails-nested-has-many-association-finding-all-children

    @invoice = Invoice.new
    @invoice.due_at = Time.now + 4.weeks
    @invoice.from = @current_organisation.name
    @invoice.from_address = @current_organisation.current_address
    @invoice.uuid = `uuidgen`.strip.downcase
    @invoice.line_items.build
    
    if @current_organisation.invoices.blank?
      @invoice.invoice_number = 1
    else
      @invoice.invoice_number = @current_organisation.invoices.first.invoice_number + 1
    end
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.organisation = @current_organisation
    @invoice.client = Address.find_by_id(params[:invoice][:to_address_id]).addressable

    if @invoice.save
      flash[:success] = t('controllers.invoices_controller.actions.create.success', :state => @invoice.state)
      redirect_to @invoice
    else
      render :action => "new"
    end
  end

  def edit
    @invoice = @current_organisation.invoices.find_by_id(params[:id])
  end

  def update
    @invoice = @current_organisation.invoices.find_by_id(params[:id])

    if @invoice.update_attributes(params[:invoice])
      flash[:success] = t('controllers.invoices_controller.actions.update.success', :state => @invoice.state)
      redirect_to @invoice
    else
      render action: "edit"
    end
  end
end
