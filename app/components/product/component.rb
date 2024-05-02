# frozen_string_literal: true

class Product::Component < ApplicationComponent
  attr_reader :date, :name, :amount, :status, :image

  def initialize(id: nil, date:, name:, amount:, status: nil, image: nil, user_id:)
    @id   = id
    @date = date
    @name = name
    @amount = amount
    @status = status
    @image  = image
    @user_id = user_id
  end

  private

  def user_full_name
    user = User.find_by(id: @user_id)
    user ? "#{user.name} #{user.surname}" : nil
  end

  def user_short_name
    user_full_name ? user_full_name.split(' ').map(&:first).join : nil
  end

  def products_amount
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
    case @status.to_sym
    when :accepted
      "abgeschlossen"
    when :denied
      "abgelehnt"
    else
      "in Bearbeitung"
    end
  end
end
