class Admin::LarvaeController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_larva, only: %i[ update destroy ]

  def create
    @larva = Larva.new(larva_params)

    respond_to do |format|
      if @larva.save
        format.html { redirect_to admin_field_form_path(@larva.test_tube.field_form), notice: 'Espécie adicionado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_field_form_path(@larva.test_tube.field_form), alert: @larva.errors.full_messages.join(', ') }
        format.json { render json: @larva.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @larva.update(larva_params)
        format.html { redirect_to admin_larva_path(@larva), notice: 'Analise atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @larva }
      else
        format.html { render :edit }
        format.json { render json: @larva.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @larva.destroy
    respond_to do |format|
      format.html { redirect_to admin_larvas_url, notice: 'Analise apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_larva
    @larva = Larva.find(params[:id])
  end

  def larva_params
    params.require(:larva).permit(:test_tube_id, :larva_species_id, :block, :comments)
  end
end
