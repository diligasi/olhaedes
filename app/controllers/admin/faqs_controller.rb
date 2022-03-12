class Admin::FaqsController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_faq, only: %i[ show edit update destroy ]

  def index
    @faqs = Faq.order(:id).page(page).per(per_page)
  end

  def show; end

  def new
    @faq = Faq.new
  end

  def edit; end

  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to admin_faq_path(@faq), notice: 'FAQ com sucesso.' }
        format.json { render :show, status: :created, location: @faq }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to admin_faq_path(@faq), notice: 'FAQ atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @faq }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to admin_faqs_url, notice: 'FAQ apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end
