class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :goal, null: false
      t.integer :user_id, null: false
      t.boolean :completed, null: false
      t.boolean :secret, null: false
      
      t.timestamps
    end
  end
end
