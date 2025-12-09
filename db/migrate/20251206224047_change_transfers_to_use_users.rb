class ChangeTransfersToUseUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :transfers, :sender, :string
    remove_column :transfers, :receiver, :string
    add_reference :transfers, :sender, null: false, foreign_key: { to_table: :users }
    add_reference :transfers, :receiver, null: false, foreign_key: { to_table: :users }
  end
end
