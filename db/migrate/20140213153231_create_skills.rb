class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
  end
end
