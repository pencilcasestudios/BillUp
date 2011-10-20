prawn_document(page_size: "A4", page_layout: :landscape) do |pdf|
  pdf.font "Helvetica"
  pdf.font_size = 9

  #pdf.stroke_bounds

  pdf.bounding_box([0,523], width: 210, height: 523) do
    #pdf.stroke_bounds
    pdf.text "#{t("views.invoices.show.copy.states.#{@invoice.state}")} #{@invoice.invoice_number}", size: 18, style: :bold
    pdf.text "#{t("views.invoices.show.labels.uuid")}#{t("views.application.copy.full_colon")} #{@invoice.uuid}"

    pdf.text "\n"

    pdf.text t("views.invoices.show.labels.to"), style: :bold
    pdf.text @invoice.to
    pdf.text @invoice.to_address

    pdf.text "\n"

    pdf.text t("views.invoices.show.labels.from"), style: :bold
    pdf.text @invoice.from
    pdf.text @invoice.from_address

    pdf.text "\n\n"

    pdf.text t("views.invoices.show.labels.dates"), style: :bold
    pdf.text "#{t("views.invoices.show.labels.invoiced_at")}#{t("views.application.copy.full_colon")} #{@invoice.invoiced_at.strftime("%A, %m %B %Y")}"
    pdf.text "#{t("views.invoices.show.labels.due_at")}#{t("views.application.copy.full_colon")} #{@invoice.due_at.strftime("%A, %m %B %Y")}"
    # TODO: PAID AT
  end
  
  pdf.bounding_box([220,523], width: 550, height: 50) do
    #pdf.stroke_bounds
    pdf.text t("views.invoices.show.labels.description"), size: 18, style: :bold
    pdf.text @invoice.description
  end

  pdf.bounding_box([220,465], width: 550, height: 380) do
    #invoiceinfo = [
    #  ["Item Name", "#{@invoice.item_name}"],
    #  ["Item Price", "#{@invoice.item_price}"],
    #  ["Item Quantity", "#{@invoice.item_qty}"]
    #]
    #
    #pdf.table invoiceinfo,
    #:border_style => :grid,
    #:font_size => 11,
    #:position => :center,
    #:column_widths => { 0 => 150, 1 => 250},
    #:align => { 0 => :right, 1 => :left, 2 => :right, 3 => :left},
    #:row_colors => ["eeeeee", "ffffff"]

    #pdf.stroke_bounds
    #
    #  	<div id="line_items">
    #  		<table class="zebra-striped">
    #  			<thead>
    #  				<tr>
    #  					<th class="quantity"><%= t("views.invoices.table.headings.quantity") %></th>
    #  					<th class="description"><%= t("views.invoices.table.headings.description") %></th>
    #  					<th class="sub_factor"><%= t("views.invoices.table.headings.sub_factors") %></th>
    #  					<th class="cost"><%= t("views.invoices.table.headings.unit_price") %></th>
    #  					<th class="total"><%= t("views.invoices.table.headings.total") %></th>
    #  				</tr>
    #  			</thead>
    #  			<tbody>
    #  			<% @invoice.line_item_units.each do |currency, line_items| %>
    #  				<% currency_total = 0.0 %>
    #  				<% for line_item in line_items do %>
    #  					<% currency_total = currency_total + line_item.total %>
    #  					<tr>
    #  						<td class="quantity"><%= line_item.quantity %></td>
    #  						<td class="description"><%=simple_format(line_item.description) %></td>
    #  						<td class="sub_factor">
    #  							<% line_item.sub_factors.each do |sub_factor| %>
    #  								<%= sub_factor.amount %>
    #  								<%= sub_factor.units %>
    #  							<% end %>
    #  						</td>
    #  						<td class="cost"><%= t("models.currency.codes.#{line_item.currency}") %><%= number_to_currency(line_item.unit_price, :unit => "") %></td>
    #  						<td class="total"><%= t("models.currency.codes.#{line_item.currency}") %><%= number_to_currency(line_item.total, :unit => "") %></td>
    #  					</tr>
    #  				<% end %>
    #  				<tr class="currency_total">
    #  					<td class="units" colspan="4"><strong><%= t("views.invoices.table.headings.total") %></strong></td>
    #  					<td class="total"><strong><%= t("models.currency.codes.#{line_item.currency}") %><%= number_to_currency(currency_total, :unit => "") %></strong></td>
    #  				</tr>
    #  			<% end %>
    #  			</tbody>
    #  		</table>
    #  		<!-- /Invoice Line Items -->
    #  	</div>
  end
  
  pdf.bounding_box([220,75], width: 550, height: 75) do
    #pdf.stroke_bounds
    if @invoice.notes.present?
      pdf.text t("views.invoices.show.labels.notes"), style: :bold
      pdf.text @invoice.notes
    end

    if @invoice.terms.present?
      pdf.text t("views.invoices.show.labels.terms")
      pdf.text @invoice.terms
    end
  end
end
