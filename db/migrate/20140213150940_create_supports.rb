class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
