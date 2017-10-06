class TopicDecorator < Draper::Decorator
  decorates :topic
  delegate :title, :id, :description

  def users_count
    object.skills_count.to_i
  end

  def small_title
    topic.to_s.downcase
  end

  def supporters
    topic.users
  end

  def show_link
    users_count > 0 ? self : "#"
  end

end
