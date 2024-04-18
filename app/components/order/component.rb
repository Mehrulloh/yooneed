# frozen_string_literal: true

class Order::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :image

  def initialize(date:, name:, amount:, status: nil)
    @date = date
    @name = name
    @amount = amount
    @status = status
    @image_for = image_for
    @amount_of_products = amount_of_products
  end

  private

  def image_for
    image.present? ? image_tag_for(image) : default_image_tag
  end

  def image_tag_for(source)
    image_tag(source, class: "rounded-full bg-red-800")
  end

  def default_image_tag
    image_tag('https://via.placeholder.com/50', class: "rounded-full bg-red-800")
  end

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
