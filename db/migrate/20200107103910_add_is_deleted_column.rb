class AddIsDeletedColumn < ActiveRecord::Migration
  def up
    add_column :notes, :is_deleted, :boolean
  end

  def down
    remove_column :notes, :is_deleted
  end
end
