module Admin::FieldFormsHelper

  def field_form_list_address(field_form)
    "#{field_form.street}, #{field_form.number} - #{field_form.block}, #{field_form.district}, #{field_form.city}, #{field_form.state} - #{field_form.zipcode}"
  end

  def field_form_list_larvae_status_component(status)
    status ? '<i class="fas fa-exclamation-triangle" style="color: #f53800;"></i> Larva presente'.html_safe : '<i class="fas fa-check-square" style="color: #21bf21;"></i> Sem larva'.html_safe
  end

  def field_form_list_status_component(status)
    status ? '<i class="fas fa-check-square" style="color: #21bf21;"></i> Completa'.html_safe : '<i class="fas fa-exclamation-triangle" style="color: #ffcc00;"></i> Pendente'.html_safe
  end

  def field_form_filled_list_status_component(field_form)
    if !field_form.larvae_found || (field_form.larvae_found && field_form.test_tubes.size.positive? && field_form.test_tubes.sum { |x| x.collected_amount.to_i }.positive?)
      '<i class="fas fa-check-square" style="color: #21bf21;"></i> Completa'.html_safe
    else
      '<i class="fas fa-exclamation-triangle" style="color: #ffcc00;"></i> Pendente'.html_safe
    end
  end

  def field_form_simple_status_component(status)
    status ? '<i class="fas fa-check-square" style="color: #21bf21;"></i>'.html_safe : '<i class="fas fa-square" style="color: #dadfda;"></i>'.html_safe
  end

  def field_form_statuses_name_for_human(status)
    I18n.t("activerecord.attributes.field_form.statuses.#{status}")
  end

  def field_form_statuses_name_for_selection
    FieldForm.statuses.keys.map do |status|
      [field_form_statuses_name_for_human(status), status]
    end
  end
end
