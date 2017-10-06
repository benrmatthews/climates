class User < ActiveRecord::Base

  has_many :skills
  has_many :topics, through: :skills
  has_many :supports
  has_many :received_supports, class_name: 'Support',
                               inverse_of: :receiver,
                               foreign_key: :receiver_id
  has_many :comments

  default_scope { active }
  scope :active, -> { where(archived_at: nil) }
  scope :sorted, -> { order('supports_count DESC, lower(first_name) ASC') }

  def name
    "#{first_name} #{last_name}".strip
  end

  def to_s
    name
  end

  def has_pending_supports?
    supports.not_done.any?
  end

  def pending_supports_count
    supports.not_done.count
  end

  def helps_with?(topic)
    skills.where(topic_id: topic.id).any?
  end

  def archived?
    archived_at.present?
  end

  def self.this_week_best_users
    joins(:supports)
      .merge(Support.unscoped.from_beginning_of_week)
      .group('users.id')
      .order('COUNT(supports) DESC, lower(first_name) ASC')
      .limit(10)
  end
end
