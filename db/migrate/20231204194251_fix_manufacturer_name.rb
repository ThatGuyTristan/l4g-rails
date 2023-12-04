class FixManufacturerName < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :systems, :manufcaturer, :manufacturer
  end

  def self.down
    rename_column :systems, :manufacturer, :manufcaturer
  end
end

