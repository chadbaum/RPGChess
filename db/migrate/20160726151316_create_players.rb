class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :black_or_white
      t.integer :game_id
      t.integer :user_id

      t.timestamps
    end
  end
end
