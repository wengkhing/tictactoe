class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.belongs_to :game
      t.integer :played_by
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
