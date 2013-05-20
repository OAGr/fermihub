class CreateDistributionsModels < ActiveRecord::Migration
  def up
    create_table :distributions_models, :id => false do |t|
      t.integer :distribution_id
      t.integer :model_id
    end
  end
  def down
    drop_table :distributions_models
  end
end
