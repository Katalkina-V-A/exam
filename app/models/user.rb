class User < ActiveRecord::Base
  has_secure_password

ROLES = %w(Пользователь Администратор)
SEXES = %w(Мужской Женский)

validates :name, presence: true, length: {minimum: 2, maximum: 255}
validates :email, presence: true, uniqueness: {case_sensitive: false},
          format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
validates :role, presence: true, inclusion: {in: 0..ROLES.size}
validates :sex, presence: true, inclusion: {in: 0..SEXES.size}
validates :password, presence: {on: :create}, format: {with: /\A(^(?=.*[a-z])(?=.*[0-9])).{6,}\z/}
has_and_belongs_to_many :films
before_validation :set_default_role

scope :ordering,->{order(:name)}

def set_default_role
  self.role||=0
end

def role_name
  role && ROLES[role]
end
def sex_name
  sex && SEXES[sex]
end

def admin?
  role == 1
end


  def self.edit_by?(u)
    u.try(:admin?)
  end


  def self.edit_user_by?(u, cu)
    u == cu || cu.try(:admin?)
  end
end
