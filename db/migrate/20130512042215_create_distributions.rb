class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.float :value
      t.float :interval
      t.float :wideness

      t.timestamps
    end
  end
end
