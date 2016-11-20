class AddAdmitToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :admit, :integer, default: 0
  end
end
