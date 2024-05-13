# frozen_string_literal: true

class Supervisor::Component < ApplicationComponent
  attr_reader :id, :date, :name, :amount, :status, :image, :user_id

  def initialize(id: nil, date:, name:, amount:, status: nil, user_id: nil)
    @id      = id
    @date    = date
    @name    = name
    @amount  = amount
    @status  = status
    @user_id = user_id
  end

  private

  def user_full_name
    user = User.find_by(id: @user_id)
    user ? "#{user.name} #{user.surname}" : nil
  end
end
