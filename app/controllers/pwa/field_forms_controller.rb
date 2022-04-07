class Pwa::FieldFormsController < Pwa::PwaController
  protect_from_forgery with: :null_session, only: :create

  load_and_authorize_resource except: :create

  before_action :set_field_form, only: %i[ show edit update ]

  def index
    date_range = Date.today.beginning_of_month..Date.today.end_of_month
    field_forms = current_user.field_forms
                               .includes(:test_tubes)
                               .where(created_at: date_range)
                               .order(created_at: :desc)

    # Throws any field form with pending completion to the top of
    # the list. A field form will be pending when the value of the
    # 'larvae_found' attribute were true and it still does not have
    # any registered test tubes or no amount of larvae registered
    # in the test tubes.
    field_forms_ids = field_forms.sort_by do |el|
      (
        el.larvae_found && (!el.test_tubes.size.positive? || !el.test_tubes.sum { |x| x.collected_amount.to_i }.positive?)
      ) ? 0 : 1
    end.pluck(:id)

    # As the sort_by of the previous sort returns an Array, and this
    # affects the pagination, in the line below we use the already
    # ordered 'field_forms_ids' to search again for the records and
    # return an 'ActiveRecord_Relation' class to the paginate.
    @field_forms = FieldForm.includes(:test_tubes)
                            .where(id: field_forms_ids)
                            .order(Arel.sql("position(id::text in '#{field_forms_ids.join(',')}')"))
                            .page(page).per(per_page)
  end

  def show; end

  def new
    @field_form = FieldForm.new
  end

  def edit; end

  def create
    result = false
    @field_form = FieldForm.new(field_form_params)
    test_tubes_group = test_tubes_params

    ActiveRecord::Base.transaction do
      unless test_tubes_group['test_tubes'].blank?
        JSON.parse(test_tubes_group['test_tubes']).each do |tube|
          @field_form.test_tubes << TestTube.new(tube.except('shed_type_name'))
        end
      end

      result = true if @field_form.save
    end

    respond_to do |format|
      if result
        format.html { redirect_to field_form_path(@field_form), notice: 'Ficha criada com sucesso.' }
        format.json { render :show, status: :created, location: @field_form }
      else
        format.html { render :new }
        format.json { render json: @field_form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = false
    test_tubes_group = test_tubes_params

    ActiveRecord::Base.transaction do
      @field_form.test_tubes.destroy_all
      unless test_tubes_group['test_tubes'].blank?
        JSON.parse(test_tubes_group['test_tubes']).each do |tube|
          @field_form.test_tubes << TestTube.new(tube.except('shed_type_name'))
        end
      end

      result = true if @field_form.update(field_form_params)
    end

    respond_to do |format|
      if result
        format.html { redirect_to field_form_path(@field_form), notice: 'Ficha de campo atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @field_form }
      else
        format.html { render :edit }
        format.json { render json: @field_form.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_field_form
    @field_form = FieldForm.find(params[:id])
  end

  def field_form_params
    params.require(:field_form).permit(:user_id, :street, :number, :block, :complement, :district, :city, :state,
                                       :country, :zipcode, :property_type_id, :visit_status, :visit_comment,
                                       :larvae_found, :larvicide, :rodenticide)
  end

  def test_tubes_params
    params.require(:field_form).permit(:test_tubes)
  end
end
