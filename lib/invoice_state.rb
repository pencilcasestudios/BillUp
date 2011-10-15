class InvoiceState < ActiveRecord::Base
  NAME = {
    # Translation                                                             # Database key
    I18n.t("views.invoices._form.fields.invoice")                =>           "invoice",
    I18n.t("views.invoices._form.fields.quote")                =>             "quote",
  }
end
