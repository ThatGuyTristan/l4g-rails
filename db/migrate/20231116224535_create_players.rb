class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :username
      t.string :headline
      t.string :timezone
      t.string :playstyle
      t.string :pfp_src

      t.timestamps
    end

    add_belongs_to :players, :user
  end
end
