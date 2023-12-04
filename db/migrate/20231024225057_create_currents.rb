class CreateCurrents < ActiveRecord::Migration[7.0]
  def change
    create_table :current do |t|

      t.timestamps
    end
  end
end
