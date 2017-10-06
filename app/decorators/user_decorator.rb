class UserDecorator < Draper::Decorator

  decorates :user

  delegate :email, :id, :supports_count, :pending_supports_count, :archived?,
           :received_supports

  def self.decorate(*args)
    decorator_class = if args.first.present? # object
                        UserDecorator
                      else
                        UserDecorator::Unavailable
                      end
    decorator_class.new *args
  end

  def topic_class(topic)
    'active' if object.helps_with?(topic.object)
  end

  def help_summary(topic)
    object.helps_with?(topic.object) ? "you can help with that!" : "you are not helping yet."
  end

  def gravatar(size = 80)
    h.gravatar_image_tag(object.email, size)
  end

  def info
    h.content_tag :span, h.raw(h.link_to(gravatar + to_s, object)), class: 'user-info'
  end

  def profile_link
    h.link_to user, h.user_path(object)
  end

  def to_s
    object.to_s.titleize
  end

  def points_from_beginning_of_week
    object.supports.from_beginning_of_week.count
  end

  class Unavailable < UserDecorator
    def gravatar(size = 80)
      h.gravatar_image_tag '', size
    end

    def to_s
      'Archived user'
    end

    def profile_link
      h.link_to self, '#'
    end
  end
end
