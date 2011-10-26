prawn_document(page_size: "A4", page_layout: :landscape, filename: @invoice.file_name, force_download: true) do |pdf|
  if @invoice.client.pdf_password.present?
   pdf.encrypt_document user_password: @invoice.client.pdf_password, owner_password: :random
  end

  pdf.font "Helvetica"
  pdf.font_size = 9

  #pdf.stroke_bounds

  pdf.bounding_box([0,523], width: 198, height: 523) do
    #pdf.stroke_bounds
    pdf.text "#{t("views.invoices.show.copy.states.#{@invoice.state}")} #{ @invoice.invoice_number}", size: 18, style: :bold, align: :right

    pdf.move_down(1) # Align with the description text
    pdf.text "#{t("views.invoices.show.labels.uuid")}#{t("views.application.copy.full_colon")} #{@invoice.uuid}", size: 8, align: :right

    pdf.text "\n\n"

    pdf.text t("views.invoices.show.labels.to"), style: :bold, align: :right
    pdf.text @invoice.to, size: 16, align: :right
    pdf.text @invoice.to_address, align: :right

    pdf.text "\n"

    pdf.text t("views.invoices.show.labels.from"), style: :bold, align: :right
    pdf.text @invoice.from, size: 15, align: :right
    pdf.text @invoice.from_address, align: :right

    pdf.text "\n\n"

    pdf.text t("views.invoices.show.labels.invoiced_at"), style: :bold, align: :right
    pdf.text @invoice.invoiced_at.strftime("%A, %d %B %Y"), align: :right
    
    pdf.text "\n"

    pdf.text t("views.invoices.show.labels.due_at"), style: :bold, align: :right
    pdf.text @invoice.due_at.strftime("%A, %d %B %Y"), size: 16, align: :right

    # TODO - Figure out how I'm going to do reconciliation for invoices
    #if @invoice.paid_at.present?
    #  pdf.text "#{t("views.invoices.show.labels.paid_at")}#{t("views.application.copy.full_colon")} #{@invoice.paid_at.strftime("%A, %d %B %Y")}"
    #end
  end
  
  pdf.bounding_box([220,523], width: 550, height: 75) do
    #pdf.stroke_bounds
    pdf.text t("views.invoices.show.labels.description"), size: 18, style: :bold
    pdf.text @invoice.description
  end

  pdf.bounding_box([220,440], width: 550, height: 355) do
    pdf.stroke_color "cccccc"
    pdf.stroke_bounds
    table_data = [
      [
        t("views.invoices.table.headings.quantity"),
        t("views.invoices.table.headings.description"),
        t("views.invoices.table.headings.sub_factors"),
        t("views.invoices.table.headings.unit_price"),
        t("views.invoices.table.headings.total")
      ]
    ]

    totals = []
    
    @invoice.line_item_units.each do |currency, line_items|
      currency_total = 0.0
      for line_item in line_items do
        currency_total = currency_total + line_item.total
        sub_line_array = []
        line_item.sub_factors.each do |sub_factor|
          sub_line_array << "#{sub_factor.amount} #{sub_factor.units}"
        end
        sub_line = sub_line_array.join(",\n")
        
        line = [
          line_item.quantity,
          line_item.description,
          sub_line,
          "#{t("models.currency.codes.#{line_item.currency}")}#{number_to_currency(line_item.unit_price, :unit => "")}",
          "#{t("models.currency.codes.#{line_item.currency}")}#{number_to_currency(line_item.total, :unit => "")}"
        ]
        table_data << line
      end
      totals << "#{t("views.invoices.table.headings.total")}#{t("views.application.copy.full_colon")} #{t("models.currency.codes.#{line_item.currency}")}#{number_to_currency(currency_total, :unit => "")}"
     end
     
    pdf.table table_data,
    column_widths: { 0 => 50, 1 => 210, 2 => 70, 3 => 110, 4 => 110 },
    row_colors: ["efefef", "ffffff"]

    pdf.move_down(10)
    
    totals.each do |total|
      pdf.indent 5, 5 do
        pdf.text total, size: 16, style: :bold, align: :right
      end
    end
  end
  
  if @invoice.terms.present?
    pdf.bounding_box([220,75], width: 271, height: 75) do
      #pdf.stroke_bounds
      pdf.text t("views.invoices.show.labels.terms"), style: :bold
      pdf.text @invoice.terms, size: 8
    end
  end

  if @invoice.notes.present?
    pdf.bounding_box([499,75], width: 271, height: 75) do
      #pdf.stroke_bounds
      pdf.text t("views.invoices.show.labels.notes"), style: :bold
      pdf.text @invoice.notes, size: 8
    end
  end
end
