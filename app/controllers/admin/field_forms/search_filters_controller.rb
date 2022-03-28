module Admin::FieldForms
  class SearchFiltersController < Admin::AdminController

    def index
      query = if current_admin_user.admin?
                FieldForm.includes(:test_tubes, user: [region: [:department]]).where(nil)
              else
                FieldForm.includes(:test_tubes, user: [region: [:department]]).where(users: { regions: { department: current_admin_user.region&.department } })
              end

      query = query.by_agent_name(params[:by_agent_name]) if params[:by_agent_name].present?
      query = query.by_address(params[:by_address]) if params[:by_address].present?

      if params[:by_date_range].present?
        range = params[:by_date_range].split(' - ').map { |dt| Date.strptime(dt, '%d/%m/%Y') }
        query = query.by_date_range(range)
      end

      query = query.by_field_form_status(params[:by_field_form_status]) if params[:by_field_form_status].present?
      query = query.by_property_type(params[:by_property_type]) if params[:by_property_type].present?
      query = query.by_shed_type(params[:by_shed_type]) if params[:by_shed_type].present?
      query = query.by_larva_species(params[:by_larva_species]) if params[:by_larva_species].present?
      query = query.by_larvae_amount(params[:by_larvae_amount]) if params[:by_larvae_amount].present?

      query = query.order('departments.id desc, field_forms.created_at, field_forms.status')
      @field_forms = query.reorder('field_forms.status, field_forms.created_at, field_forms.larvae_found, departments.id desc').page(page).per(per_page)

      render 'admin/field_forms/index'
    end
  end
end
