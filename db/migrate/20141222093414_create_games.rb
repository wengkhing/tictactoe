class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :p1_id
      t.integer :p2_id
      t.integer :status, default: 0
      t.integer :winner_id
      t.integer :turn, default: 1
      t.timestamps
    end
  end
end
