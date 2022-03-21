class Admin::UsersController < Admin::AdminController
  load_and_authorize_resource

  before_action :set_user,          only: %i[ show edit update destroy ]
  before_action :set_password_user, only: %i[ edit_password update_password ]

  def index
    @users = User.order(:role, :id).page(page).per(per_page)
  end

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def edit_password; end

  def create
    @user = User.new(user_params)
    @user.password = SecureRandom.urlsafe_base64(10, false)

    respond_to do |format|
      if @user.save
        @user.send_reset_password_instructions
        format.html { redirect_to admin_user_path(@user), notice: 'Usuário criado com sucesso.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'Usuário atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(password_params)
        sign_in @user, :bypass => true
        format.html { redirect_to admin_user_path(@user), notice: 'Senha atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit_password, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'Usuário apagado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def filter_regions_by_department
    @filtered_regions = Region.where(department_id: params[:selected_department])
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_password_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :cpf, :email, :status, :role, :region_id)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
