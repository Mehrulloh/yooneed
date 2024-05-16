# frozen_string_literal: true

class Order::Component < ApplicationComponent
  with_collection_parameter :order

  def initialize(order:)
    @order = order
  end
end
