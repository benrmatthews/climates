class CommentOnSkipping < CommentOnSupport
  attr_accessor :support_user

  def initialize(user, support, support_user)
    self.user = user
    self.support = support
    self.support_user = support_user
  end

  private

  def comment_params
    {
      body: comment_body
    }
  end

  def comment_body
    I18n.t('support.skip.comment',
           previous_user: user,
           current_user: support_user)
  end
end
