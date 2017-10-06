class AddCommentsCountToSupports < ActiveRecord::Migration
  class Support < ActiveRecord::Base
    has_many :comments
  end

  class Comment < ActiveRecord::Base
    belongs_to :support
  end

  def change
    add_column :supports, :comments_count, :integer, default: 0

    Support.reset_column_information
    Support.find_each do |support|
      support.update_attribute :comments_count, support.comments.count
    end
  end
end
