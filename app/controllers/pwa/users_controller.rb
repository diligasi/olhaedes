class Pwa::UsersController < Pwa::PwaController
  before_action :set_user, only: %i[ show edit update edit_password update_password ]

  def show; end

  def edit; end

  def edit_password; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'Usuário atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    respond_to do |format|
      if @user.update_with_password(password_params)
        sign_in @user, :bypass => true
        format.html { redirect_to user_path(@user), notice: 'Senha atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit_password, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
