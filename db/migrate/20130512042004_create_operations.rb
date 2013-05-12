class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.string :operator

      t.timestamps
    end
  end
end
