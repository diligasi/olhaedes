class Admin::DepartmentsController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_department, only: %i[ show edit update destroy ]

  def index
    @departments = Department.order(:name).page(page).per(per_page)
  end

  def show; end

  def new
    @department = Department.new
  end

  def edit; end

  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to admin_department_path(@department), notice: 'Secretaria criada com sucesso.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to admin_department_path(@department), notice: 'Secretaria atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to admin_departments_url, notice: 'Secretaria apagada com sucesso.' }
      format.json { head :no_content }
    end
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
