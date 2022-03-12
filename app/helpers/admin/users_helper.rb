module Admin::UsersHelper

  def roles_name_for_human(role)
    I18n.t("activerecord.attributes.user.roles.#{role}")
  end

  def roles_name_for_selection
    User.roles.keys.map do |role|
      [roles_name_for_human(role), role]
    end
  end

  def user_list_status_component(status)
    status ? '<i class="fas fa-check-square" style="color: #21bf21;"></i>'.html_safe : '<i class="fas fa-ban" style="color: #f53800;"></i>'.html_safe
  end

  def cpf_formatter(cpf)
    cpf.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/) { "#{$1}.#{$2}.#{$3}-#{$4}" }
  end
end
