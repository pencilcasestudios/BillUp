#prawn_document(page_size: "A4", page_layout: :portrait) do |pdf|
prawn_document(page_size: "A4", page_layout: :portrait, filename: @receipt.file_name, force_download: true) do |pdf|
  #if @receipt.client.pdf_password.present?
  # pdf.encrypt_document user_password: @receipt.client.pdf_password, owner_password: :random
  #end

  pdf.font "Helvetica"
  pdf.font_size = 9

  #pdf.stroke_bounds

  pdf.bounding_box([0,770], width: 523, height: 70) do
    #pdf.stroke_bounds

    pdf.text "#{t("views.receipts.show.copy.receipt")} #{ @receipt.receipt_number}", size: 20, style: :bold, align: :right
    pdf.text "#{t("views.receipts.show.labels.uuid")}#{t("views.application.copy.full_colon")} #{@receipt.uuid}", align: :right
  end
  
  pdf.bounding_box([273,700], width: 250, height: 150) do
    #pdf.stroke_bounds

    pdf.text t("views.receipts.show.labels.to"), style: :bold#, align: :right
    pdf.text @receipt.to, size: 16#, align: :right
    pdf.text @receipt.to_address#, align: :right
  end
  
  pdf.bounding_box([0,700], width: 250, height: 150) do
    #pdf.stroke_bounds

    pdf.text t("views.receipts.show.labels.from"), style: :bold, align: :right
    pdf.text @receipt.from, size: 15, align: :right
    pdf.text @receipt.from_address, align: :right
  end

  pdf.bounding_box([102,530], width: 306, height: 350) do
    #pdf.stroke_bounds

    pdf.text t("views.receipts.show.copy.acknowledgement",
		organisation: @receipt.organisation.name,
		amount: "#{t("models.currency.codes.#{@receipt.currency}")}#{number_to_currency(@receipt.amount, unit: "")}",
		payment_method: t("views.receipts.show.copy.payment_method.#{@receipt.payment_method}"),
		client: @receipt.client.name,
		payment_date: @receipt.received_at.strftime("%A, %d %B %Y"),
		), size: 14

    pdf.move_down(14)
    pdf.text t("views.receipts.show.labels.description"), size: 18, style: :bold
    pdf.text @receipt.description, size: 14

    pdf.move_down(28)
    pdf.text t("views.receipts.show.copy.total_received", amount: "#{t("models.currency.codes.#{@receipt.currency}")}#{number_to_currency(@receipt.amount, unit: "")}"), size: 14, style: :bold
		
  end
  
  if @receipt.notes.present?
    pdf.bounding_box([102,150], width: 306, height: 150) do
      #pdf.stroke_bounds
      
      pdf.text t("views.receipts.show.labels.notes"), style: :bold
      pdf.text @receipt.notes, size: 8
    end
  end
end
