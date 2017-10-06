class Comment < ActiveRecord::Base
  belongs_to :support, counter_cache: true
  belongs_to :user

  scope :sorted, -> { order('created_at ASC') }
end
