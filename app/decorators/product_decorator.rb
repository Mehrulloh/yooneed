class ProductDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%d %B")
  end

  def current_time
    DateTime.now.strftime("%d %B")
  end

  def packing
    return "Kisten" if packing_type.to_sym == :boxes
    return "Packung" if packing_type.to_sym  == :pack

    "Stück" if packing_type.to_sym  == :piece
  end

end
