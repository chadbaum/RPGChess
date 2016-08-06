class ChangePlayersTable < ActiveRecord::Migration[5.0]
  def change_table :players do |t|
    t.rename :black_or_white, :color
  end
end
