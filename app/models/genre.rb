class Genre < ActiveRecord::Base
  has_many :films, -> { ordering.base }, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  scope :ordering, ->{order(:name)}

  before_destroy :can_destroy?

  def self.edit_by?(u)
    u.try(:admin?)
  end

  def can_destroy?
    films.blank?
  end

  def self.quantity(id)
    Genre.joins(:films).where('films.genre_id = ?', id).count    
  end
end
