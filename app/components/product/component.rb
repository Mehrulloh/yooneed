# frozen_string_literal: true

class Product::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :status, :image, :amount_of_products

  def initialize date:, name:, amount:, status: nil, image: nil
    @date           = date
    @name, @amount  = name,amount
    @image, @status = image, status
  end

  private

  def amount_of_products
    case name.downcase
    when "wasser"
      pluralize(amount, "Kasten", "Kästen")
    when "zewa"
      pluralize(amount, "Roll", "Rollen")
    when "milch"
      pluralize(amount, "Packung", "Packungen")
    else
      "#{amount} #{name}"
    end
  end

  def pluralize(count, singular, pluralize)
    count > 1 ? "#{count} #{pluralize}" : "#{count} #{singular}"
  end
end
