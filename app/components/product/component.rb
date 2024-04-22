# frozen_string_literal: true

class Product::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :status, :image, :amount_of_products, :username, :user_name_for

  def initialize(date:, name:, amount:, status: nil, image: nil, user_id:)
    @date = date
    @name = name
    @amount = amount
    @status = status
    @image = image
    @username = find_user(user_id)
    @user_name_for = user_name_for(@username)
    @amount_of_products = calculate_amount_of_products
  end

  private

  def find_user(user_id)
    user = User.find_by(id: user_id)
    user&.full_name # Return nil if user not found, otherwise return full name
  end

  def user_name_for(username)
    return unless username # Return nil if username is nil
    first_name, last_name = username.split(' ')
    "#{first_name[0]}#{last_name[0]}"
  end

  def calculate_amount_of_products
    case name.downcase
    when "wasser"
      pluralize("Kasten", "Kästen")
    when "zewa"
      pluralize("Roll", "Rollen")
    when "milch"
      pluralize("Packung", "Packungen")
    else
      "#{amount} #{name}"
    end
  end

  def pluralize(singular, pluralize)
    amount > 1 ? "#{amount} #{pluralize}" : "#{amount} #{singular}"
  end
end
