class CreateTrashes < ActiveRecord::Migration
  def change
    create_table :trashes do |t|
      t.integer :note_id
      t.timestamp :deleted_time

      t.timestamps
    end
  end
end
