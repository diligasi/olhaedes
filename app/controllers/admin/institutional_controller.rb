class Admin::InstitutionalController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_institutional, only: %i[ edit update destroy ]

  def index
    @institutional = Institutional.first
  end

  # def show; end

  def new
    @institutional = Institutional.new
  end

  def edit; end

  def create
    @institutional = Institutional.new(processed_institutional_params)

    respond_to do |format|
      if @institutional.save
        format.html { redirect_to admin_institutional_index_path, notice: 'Informações adicionadas com sucesso.' }
        format.json { render :show, status: :created, location: @institutional }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @institutional.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @institutional.update(processed_institutional_params)
        format.html { redirect_to admin_institutional_index_path, notice: 'Informações atualizadas com sucesso.' }
        format.json { render :show, status: :ok, location: @institutional }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @institutional.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @institutional.destroy
    respond_to do |format|
      format.html { redirect_to admin_institutional_index_url, notice: 'Informações apagadas com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_institutional
    @institutional = Institutional.find(params[:id])
  end

  def institutional_params
    params.require(:institutional).permit(:description, phone_numbers: [])
  end

  def processed_institutional_params
    hsh = institutional_params.to_hash
    hsh['phone_numbers'] = institutional_params['phone_numbers'].join(',')

    hsh
  end
end
