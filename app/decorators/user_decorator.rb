class UserDecorator < ApplicationDecorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@')[0].downcase
  end

  def full_name
    "#{name} #{surname}"
  end

  def short_name
    !name.nil? ? "#{name[0]} #{surname[0]}" : full_name
  end
end