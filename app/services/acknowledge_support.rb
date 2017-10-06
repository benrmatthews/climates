class AcknowledgeSupport

  attr_accessor :user, :support

  def initialize(user, support)
    self.user = user
    self.support = support
  end

  def commence!
    reasign_user!
    comment_on_support!
  end

  private

  def reasign_user!
    support.user = user
    support.save
  end

  def comment_on_support!
    comment = CommentOnSupport.new user, support, comment_params
    comment.commence!
  end

  def comment_params
    {
      body: comment_body
    }
  end

  def comment_body
    "#{user} acknowledged this support"
  end
end

