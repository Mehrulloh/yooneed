# frozen_string_literal: true

class Product::Component < ApplicationComponent
  with_collection_parameter :product

  def initialize(product:)
    @product = product
  end
end
