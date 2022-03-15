class Admin::ShedTypesController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_shed_type, only: %i[ show edit update destroy ]

  def index
    @shed_types = ShedType.order(:name).page(page).per(per_page)
  end

  def show; end

  def new
    @shed_type = ShedType.new
  end

  def edit; end

  def create
    @shed_type = ShedType.new(shed_type_params)

    respond_to do |format|
      if @shed_type.save
        format.html { redirect_to admin_shed_type_path(@shed_type), notice: 'Local de coleta criada com sucesso.' }
        format.json { render :show, status: :created, location: @shed_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shed_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shed_type.update(shed_type_params)
        format.html { redirect_to admin_shed_type_path(@shed_type), notice: 'Local de coleta atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @shed_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shed_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shed_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_shed_types_url, notice: 'Local de coleta apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_shed_type
    @shed_type = ShedType.find(params[:id])
  end

  def shed_type_params
    params.require(:shed_type).permit(:name, :description)
  end
end
