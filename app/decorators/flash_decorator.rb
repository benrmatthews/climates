class FlashDecorator < Draper::Decorator
  def msg
    object[1]
  end

  def css_class
    "alert-#{label}"
  end

  def id
    "flash_#{name}"
  end

  private

  def name
    object[0].to_s
  end

  def label
    name == 'notice' ? 'success' : 'danger'
  end
end
