class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.decimal :balance, default: 1000.0, precision: 10, scale: 2

      t.timestamps
    end
    
    add_index :users, :nickname, unique: true
  end
end
