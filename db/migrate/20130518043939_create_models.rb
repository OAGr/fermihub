class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |m|
      m.string :name
      m.timestamps
    end
  end
end
