# frozen_string_literal: true

class Order::Component < ApplicationComponent
  with_collection_parameter :order

  def initialize(order:, current_user:)
    @order = order.decorate(context: { current_user: current_user })
    @current_user = current_user
  end
end
