class AskForSupport

  attr_accessor :supporter_id, :receiver, :topic, :support_body

  def initialize receiver, topic, support_params
    self.receiver = receiver
    self.topic = topic
    self.supporter_id = support_params[:user_id]
    self.support_body = support_params[:body]
  end

  def commence!
    setup_support
    new_support.save!
    deliver_email
    send_notification
  end

  def setup_support
    new_support.user = supporter
    new_support.topic = topic
    new_support.receiver = receiver
    new_support.body = support_body
  end

  def new_support
    @new_support ||= Support.new
  end

  def supporter
    @supporter ||= User.find(supporter_id)
  end

  private

  def deliver_email
    email = SupportMailer.help_me(new_support)
    email.deliver
  end

  def send_notification
    notification = AskForSupportNotification.new(new_support)
    Notifier.new(notification).commence!
  end
end
