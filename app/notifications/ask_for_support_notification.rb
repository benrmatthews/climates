class AskForSupportNotification < BaseNotification
  attr_accessor :support

  def initialize support
    self.support = support
  end

  def message
    "#{support.receiver} asked *#{support.user}* for help with *#{support.topic}* - #{support_url(support)}"
  end
end
