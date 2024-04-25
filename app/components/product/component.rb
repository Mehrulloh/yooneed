# frozen_string_literal: true

class Product::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :status, :image, :amount_of_products, :username, :user_name_for

  def initialize(id: nil, date:, name:, amount:, status: nil, image: nil, user_id:)
    @id = id
    @date = date
    @name = name
    @amount = amount
    @status = status
    @image = image
    @username = User.find_by(id: user_id)
    @user_name_for = set_username(@username)
    @amount_of_products = amount_of_products
  end

  private

  def set_username(username)
    return unless username # Return nil if username is nil
    first_name, last_name = username.name, username.surname
    "#{first_name[0]}#{last_name[0]}"
  end

  def amount_of_products
    case @name.downcase
    when "wasser"
      pluralize("Kasten", "Kästen")
    when "zewa"
      pluralize("Roll", "Rollen")
    when "milch"
      pluralize("Packung", "Packungen")
    else
      "#{@amount} #{@name}"
    end
  end

  def pluralize(singular, pluralize)
    @amount > 1 ? "#{@amount} #{pluralize}" : "#{@amount} #{singular}"
  end
end
