class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    nickname = params[:nickname]
    
    if nickname.blank?
      flash[:alert] = "Будь ласка, введіть нікнейм"
      redirect_to new_session_path
      return
    end
    
    user = User.find_by(nickname: nickname)
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Вітаємо, #{user.nickname}!"
    else
      flash[:alert] = "Користувача з таким нікнеймом не знайдено"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Ви вийшли з системи"
  end
end
