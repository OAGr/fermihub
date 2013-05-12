class ChangeDistibutionNames < ActiveRecord::Migration
  def change
    rename_column :distributions, :value, :mean
    rename_column :distributions, :interval, :spread
  end

end
