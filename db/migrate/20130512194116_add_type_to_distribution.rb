class AddTypeToDistribution < ActiveRecord::Migration
  def change
    add_column :distributions, :type, :string
  end
end
