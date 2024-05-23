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
    return "Packung" if  packing_type.to_sym  == :pack

    "Stück" if  packing_type.to_sym  == :piece
  end

  def humanized_packing_types
    Product.packing_types.map do |key, _|
      [translate_packing_type(key), key]
    end
  end

  private

  def translate_packing_type(key)
    case key.to_sym
    when :boxes
      "Kisten"
    when :pack
      "Packung"
    when :piece
      "Stück"
    else
      "Unbekannt"
    end
  end
end
