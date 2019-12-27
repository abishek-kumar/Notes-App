class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :id
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
