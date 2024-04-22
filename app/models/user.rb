class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify

  has_many :products, dependent: :destroy

  after_create :assign_default_role

  def full_name
    "#{name} #{surname}"
  end

  def author?(object)
    object.user == self
  end

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end
end
