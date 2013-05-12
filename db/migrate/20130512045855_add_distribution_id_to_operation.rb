class AddDistributionIdToOperation < ActiveRecord::Migration
  def change
    add_column :distributions, :operation_id, :integer
  end
end
