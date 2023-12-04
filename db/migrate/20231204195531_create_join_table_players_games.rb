class CreateJoinTablePlayersGames < ActiveRecord::Migration[7.0]
  def change
    create_join_table :games, :players, table_name: :players_games do |t|
      t.index [:game_id, :player_id]
      t.index [:player_id, :game_id]
    end
  end
end
