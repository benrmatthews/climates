class AddBodyToSupport < ActiveRecord::Migration
  def change
    add_column :supports, :body, :text
  end
end
