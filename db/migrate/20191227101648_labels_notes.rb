class LabelsNotes < ActiveRecord::Migration
  def change
    create_table :labels_notes, :id=>false do |t|
      t.integer :label_id, null: false
      t.integer :note_id, null: false
    end
  end
end
