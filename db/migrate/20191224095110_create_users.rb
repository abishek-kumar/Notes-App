class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :id, null: false, default:0
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end
