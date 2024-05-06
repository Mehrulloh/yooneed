class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, supervisor: 1 }, _prefix: true

  after_create :assign_default_role

  has_many :products, dependent: :destroy

  def full_name
    "#{name} #{surname}"
  end

  def author?(object)
    object.user == self
  end

  def assign_default_role
    self.role ||= :customer if self.role.blank?
  end

  def short_name
    !name.nil? ? "#{name[0]} #{surname[0]}" : full_name
  end
end
