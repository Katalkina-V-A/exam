class Country < ActiveRecord::Base
  has_many :films, ->{ordering.base}, dependent: :destroy
  has_many :people
  scope :ordering, -> { order(:name) }

  before_destroy :can_destroy?

  validates :name, presence: true, uniqueness: true

  CHARS = %w(А Б В Г Д Е З И Й К Л М Н О П Р С Т У Ф Х Ц Ч Ш Э Ю Я)

  def self.edit_by?(u)
    u.try(:admin?)
  end

  def can_destroy?
    films.blank?
  end

  def self.search(search)
    where("name like (:q)", q: "#{search}%")
  end
end
