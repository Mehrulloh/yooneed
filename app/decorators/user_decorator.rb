class UserDecorator < ApplicationDecorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@')[0].downcase
  end

  def full_name
    "#{name} #{surname}"
  end

end