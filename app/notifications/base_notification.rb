class BaseNotification
  include Rails.application.routes.url_helpers

  def to_s
    message
  end
end
