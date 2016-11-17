class AddSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret, :integer, default: 0
  end
end
