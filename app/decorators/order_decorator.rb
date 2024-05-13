class OrderDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%d %B")
  end

  def status
    status_strings = {
      processing: "in Bearbeitung",
      accepted: "abgeschlossen",
      denied: "abgelehnt"
    }
    status_strings[object.status.to_sym]
  end

end
