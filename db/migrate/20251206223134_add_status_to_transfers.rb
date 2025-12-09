class AddStatusToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :status, :string, default: 'pending'
  end
end
