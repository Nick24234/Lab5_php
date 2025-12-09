class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    # Демонстрація роботи з params - зберігаємо отримані параметри для відображення
    @submitted_params = params[:user]
    
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        # Зберігаємо params у сесії для демонстрації
        session[:registration_params] = @submitted_params
        format.html { redirect_to registration_params_users_path, notice: "Акаунт успішно створено! Вітаємо, #{@user.nickname}! Ваш баланс: #{@user.balance}₴" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/registration_params - демонстрація отриманих параметрів
  def registration_params
    @params_data = session[:registration_params] || {}
    @user = current_user # Для відображення посилання на профіль
    session.delete(:registration_params) # Очищаємо після використання
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if action_name == 'create'
        # Демонстрація роботи з params - отримуємо дані з форми через хеш params
        # params містить всі дані, відправлені з форми
        params.require(:user).permit(:nickname, :email, :full_name)
      else
        params.require(:user).permit(:nickname, :email, :full_name, :balance)
      end
    end
end
