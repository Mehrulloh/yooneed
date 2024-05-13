class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, supervisor: 1 }, _prefix: true
  has_many :products, dependent: :destroy

  after_create :assign_default_role

  # if some object belongs user
  def author?(object)
    object.user == self
  end

  def assign_default_role
    self.role ||= :customer if self.role.blank?
  end
end
