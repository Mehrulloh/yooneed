# frozen_string_literal: true

class Product::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :status, :image, :amount_of_products, :username, :user_name_for

  def initialize(id: nil, date:, name:, amount:, status: nil, image: nil, user_id:)
    @id   = id
    @date = date
    @name = name
    @amount = amount
    @status = status
    @image  = image
    @user_full_name = set_full_name(user_id)
    @user_short_name = set_short_name
    @amount_of_products = amount_of_products
  end

  private

  def set_full_name(user_id)
    user = User.find_by(id: user_id)
    user ? "#{user.name} #{user.surname}" : nil
  end

  def set_short_name
    @user_full_name ? @user_full_name.split(' ').map(&:first).join : nil
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

  def bg_color
    @status == "accepted" ? 'green' : (@status == "denied" ? 'red' : 'red')
  end

  def status
    case @status
    when :accepted
      "abgeschlossen"
    when :denied
      "abgelehnt"
    else
      "in Bearbeitung"
    end
  end
end
