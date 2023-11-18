class AddBioToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :bio, :string, :limit => 500
  end
end
