class CommentDecorator < Draper::Decorator

  decorates :comment
  delegate :id, :body, :to_key

  def commented_at
    "#{h.time_ago_in_words(object.created_at)} ago"
  end

  def created_at
    object.created_at.to_formatted_s(:short)
  end

  def user
    UserDecorator.decorate object.user
  end

  def user_gravatar(*args)
    user.gravatar(*args)
  end
end
