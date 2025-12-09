class User < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true, length: { minimum: 3, maximum: 20 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "має бути валідною email адресою" }
  validates :full_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :balance, presence: true, numericality: { greater_than_or_equal_to: 0 }
  
  has_many :sent_transfers, class_name: 'Transfer', foreign_key: 'sender_id'
  has_many :received_transfers, class_name: 'Transfer', foreign_key: 'receiver_id'
  
  after_initialize :set_default_balance, if: :new_record?
  
  def set_default_balance
    self.balance ||= 1000.0
  end
  
  def can_transfer?(amount)
    balance >= amount
  end
  
  def transfer_money(amount)
    self.balance = (self.balance || 0) - amount
    save
  end
  
  def receive_money(amount)
    self.balance = (self.balance || 0) + amount
    save
  end
end
