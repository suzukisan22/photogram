class ChangeDatatypeCommentOfPicture < ActiveRecord::Migration
  def change
    change_column :pictures, :comment, :text
  end
end
