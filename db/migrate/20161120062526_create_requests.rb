class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps null: false
    end
    add_index :requests, :sender_id
    add_index :requests, :recipient_id
    add_index :requests, [:sender_id, :recipient_id], unique: true
  end
end
