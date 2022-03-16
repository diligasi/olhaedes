class Admin::FieldFormsController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_field_form, only: %i[ show edit update ]

  def index
    @field_forms = FieldForm.includes(:test_tubes, user: [region: [:department]])
    @field_forms = @field_forms.where(users: { regions: { department: current_admin_user.region&.department } }) unless current_admin_user.admin?
    @field_forms = @field_forms.order('departments.id desc, field_forms.created_at, field_forms.status').page(page).per(per_page)
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @field_form.update(field_form_params)
        format.html { redirect_to admin_field_form_path(@field_form), notice: 'Ficha de campo atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @field_form }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @field_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_field_form
    @field_form = FieldForm.find(params[:id])
  end

  def field_form_params
    params.require(:field_form).permit(:name, :description)
  end
end
