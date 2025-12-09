class PagesController < ApplicationController
  def home
    # Головна сторінка системи переказів
  end

  def about
    # Сторінка "Про додаток"
  end

  def support
    # Сторінка підтримки з формою
    # GET запит показує форму, POST обробляється тут же
  end

  def support_result
    # Сторінка результату після відправки форми
    @name = params[:name]
    @subject = params[:subject]
    @message = params[:message]
  end
end

