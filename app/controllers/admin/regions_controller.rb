class Admin::RegionsController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_region, only: %i[ show edit update destroy ]

  def index
    @regions = Region.order(:name).page(page).per(per_page)
  end

  def show; end

  def new
    @region = Region.new
  end

  def edit; end

  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to admin_region_path(@region), notice: 'Região criada com sucesso.' }
        format.json { render :show, status: :created, location: @region }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @region.update(region_params)
        format.html { redirect_to admin_region_path(@region), notice: 'Região atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to admin_regions_url, notice: 'Região apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_region
    @region = Region.find(params[:id])
  end

  def region_params
    params.require(:region).permit(:name, :department_id)
  end
end
