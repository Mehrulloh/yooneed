class ProductDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%d %B")
  end

  def current_time
    DateTime.now.strftime("%d %B")
  end
end
