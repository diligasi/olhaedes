class Admin::PropertyTypesController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_property_type, only: %i[ show edit update destroy ]

  def index
    @property_types = PropertyType.order(:name).page(page).per(per_page)
  end

  def show; end

  def new
    @property_type = PropertyType.new
  end

  def edit; end

  def create
    @property_type = PropertyType.new(property_type_params)

    respond_to do |format|
      if @property_type.save
        format.html { redirect_to admin_property_type_path(@property_type), notice: 'Tipo de imóvel criado com sucesso.' }
        format.json { render :show, status: :created, location: @property_type }
      else
        format.html { render :new }
        format.json { render json: @property_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @property_type.update(property_type_params)
        format.html { redirect_to admin_property_type_path(@property_type), notice: 'Tipo de imóvel atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @property_type }
      else
        format.html { render :edit }
        format.json { render json: @property_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_property_types_url, notice: 'Tipo de imóvel apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_property_type
    @property_type = PropertyType.find(params[:id])
  end

  def property_type_params
    params.require(:property_type).permit(:name, :description)
  end
end
