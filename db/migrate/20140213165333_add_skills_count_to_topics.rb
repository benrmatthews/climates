class AddSkillsCountToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :skills_count, :integer, default: 0
  end
end
