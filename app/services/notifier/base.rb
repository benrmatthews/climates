class Notifier
  class Base
    attr_accessor :notification, :options

    def initialize(notification, options = {})
      self.notification = notification
      self.options = options
    end

    def call
      notify
    end
  end
end
