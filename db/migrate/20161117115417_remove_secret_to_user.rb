class RemoveSecretToUser < ActiveRecord::Migration
  def change
    remove_column :users, :secret, :integer
  end
end
