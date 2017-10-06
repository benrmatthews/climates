class AddSkillsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :skills_count, :integer, default: 0
  end
end
