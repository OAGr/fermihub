class DistributionsOperations < ActiveRecord::Migration
  def change
    create_table :distributions_operations, :id => false do |t|
      t.integer :distribution_id
      t.integer :operation_id
    end
  end
end
