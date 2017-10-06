class Support < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :user
  belongs_to :topic, counter_cache: true

  default_scope -> { order(updated_at: :desc) }
  scope :done, -> { where(done: true) }
  scope :not_done, -> { where(done: false) }
  scope :from_beginning_of_week, -> do
    done.where('supports.updated_at >= ?', Time.current.beginning_of_week)
  end

  def discussed?
    comments_count > 0
  end
end
