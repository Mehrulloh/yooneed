# frozen_string_literal: true

class Order::Component < ApplicationComponent
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
    return 'green' if @order.status.to_sym == :abgeschlossen
    return 'red' if @order.status.to_sym == :abgelehnt

    'gray'
  end
end
