class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify

  enum role: %i[customer supervisor]
  after_create :assign_default_role

  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end
end
