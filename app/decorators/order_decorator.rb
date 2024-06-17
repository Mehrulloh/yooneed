class OrderDecorator < Draper::Decorator
  delegate_all

  def name
    product.name
  end

  def username(short: true)
    user = User.find_by(id: order.user_id)

    short ? user.decorate.short_name : user.decorate.full_name
  end

  def created_at
    object.created_at.strftime("%d %B")
  end

  def status
    status_strings[object.status.to_sym]
  end

  def packing
    "#{amount} #{packing_type}"
  end

  def status_color
    case object.status.to_sym
    when :accepted
      "bg-green-600"
    when :denied
      "bg-red-500"
    else
      "bg-gray-500"
    end
  end

  private

  def amount
    object.amount
  end

  def product
    @product ||= object.product
  end

  def status_strings
    {
      processing: "in Bearbeitung",
      accepted: "abgeschlossen",
      denied: "abgelehnt"
    }
  end

  def packing_type
    case product.packing_type&.to_sym
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
