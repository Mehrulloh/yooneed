# frozen_string_literal: true

class Supervisor::Component < ApplicationComponent
  with_collection_parameter :order

  def initialize(order:)
    @order = order
  end

  private

  def user_full_name
    user = User.find_by(id: @order.user_id)
    user ? "#{user.name} #{user.surname}" : nil
  end

  def status_color
    return "bg-green-600" if @order.status.to_sym == :abgeschlossen
    return "bg-red-500" if @order.status.to_sym == :abgelehnt

    "bg-gray-500"
  end
end
