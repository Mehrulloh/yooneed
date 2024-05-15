# frozen_string_literal: true

class Product::Component < ApplicationComponent
  delegate :modal, to: :helpers

  with_collection_parameter :product

  def initialize(product:)
    @product = product
  end
end
