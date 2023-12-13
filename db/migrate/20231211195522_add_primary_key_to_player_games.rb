class AddPrimaryKeyToPlayerGames < ActiveRecord::Migration[7.0]
  def up
    add_column :player_games, :id, :primary_key
  end

  def down
    remove_column :player_games, :id
  end
end
