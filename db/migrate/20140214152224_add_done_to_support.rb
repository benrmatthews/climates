class AddDoneToSupport < ActiveRecord::Migration
  def change
    add_column :supports, :done, :boolean, default: false
  end
end
