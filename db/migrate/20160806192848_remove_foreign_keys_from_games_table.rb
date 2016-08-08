class RemoveForeignKeysFromGamesTable < ActiveRecord::Migration[5.0]
  change_table :games do |t|
    t.remove :player_id
    t.remove :user_id
  end
end
