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
    @user_fullname = set_fullname(user_id)
    @user_shortname = set_shortname
    @amount_of_products = amount_of_products
  end

  private

  def set_fullname(user_id)
    user = User.find_by(id: user_id)
    return nil unless user
    "#{user.name} #{user.surname}"
  end

  def set_shortname
    return nil unless @user_fullname
    first_name, last_name = @user_fullname.split(' ')
    "#{first_name[0]}#{last_name[0]}"
  end

  def amount_of_products
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
