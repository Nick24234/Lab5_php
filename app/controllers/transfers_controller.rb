class TransfersController < ApplicationController
  before_action :require_login
  before_action :set_transfer, only: %i[ show edit update destroy complete cancel ]


  def index
    @transfers = Transfer.all.order(created_at: :desc)
  end


  def show
  end


  def new
    @transfer = Transfer.new
    @users = User.where.not(id: current_user.id).order(:nickname)
  end


  def edit
    @users = User.all.order(:nickname)
  end

 
  def create
    @transfer = Transfer.new(transfer_params)
    @transfer.sender = current_user

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to @transfer, notice: "Переказ успішно створено." }
        format.json { render :show, status: :created, location: @transfer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to @transfer, notice: "Переказ успішно оновлено.", status: :see_other }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @transfer.destroy

    respond_to do |format|
      format.html { redirect_to transfers_path, notice: "Переказ успішно видалено.", status: :see_other }
      format.json { head :no_content }
    end
  end


  def complete
    if @transfer.pending? && @transfer.update(status: 'completed')
      redirect_to @transfer, notice: "Переказ підтверджено! Кошти успішно переказано."
    else
      redirect_to @transfer, alert: "Помилка при підтвердженні переказу."
    end
  end


  def cancel
    if @transfer.pending? && @transfer.update(status: 'cancelled')
      redirect_to @transfer, notice: "Переказ скасовано. Кошти повернуто на баланс."
    else
      redirect_to @transfer, alert: "Помилка при скасуванні переказу."
    end
  end

  private
  
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

   
    def transfer_params
      params.require(:transfer).permit(:receiver_id, :amount, :status)
    end
end
