class Admin::LarvaSpeciesController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_larva_species, only: %i[ show edit update destroy ]

  def index
    @larva_species = LarvaSpecies.order(:name).page(page).per(per_page)
  end

  def show; end

  def new
    @larva_species = LarvaSpecies.new
  end

  def edit; end

  def create
    @larva_species = LarvaSpecies.new(larva_species_params)

    respond_to do |format|
      if @larva_species.save
        format.html { redirect_to admin_larva_species_path(@larva_species), notice: 'Espécie criada com sucesso.' }
        format.json { render :show, status: :created, location: @larva_species }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @larva_species.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @larva_species.update(larva_species_params)
        format.html { redirect_to admin_larva_species_path(@larva_species), notice: 'Espécie atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @larva_species }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @larva_species.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @larva_species.destroy
    respond_to do |format|
      format.html { redirect_to admin_larva_species_index_url, notice: 'Espécie apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_larva_species
    @larva_species = LarvaSpecies.find(params[:id])
  end

  def larva_species_params
    params.require(:larva_species).permit(:name, :description)
  end
end
