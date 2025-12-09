class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.string :sender
      t.string :receiver
      t.decimal :amount

      t.timestamps
    end
  end
end
