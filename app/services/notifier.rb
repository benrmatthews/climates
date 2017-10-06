class Notifier
  attr_accessor :notification, :options

  def initialize(notification, options = {})
    self.notification = notification
    self.options = options
  end

  def commence!
    enabled_notifications.each do |notification|
      send("notify_#{notification}")
    end
  end

  private

  def notify_slack
    Notifier::SlackNotifier.new(notification, options).call
  end

  def enabled_notifications
    AppConfig.enabled_notifications
  end
end
