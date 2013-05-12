class AddNameToDistribution < ActiveRecord::Migration
  def change
    add_column :distributions, :name, :string
  end
end
