class Person < ActiveRecord::Base
  is_impressionable
  has_attached_file :avatar, styles: {medium: "250x250>", thumb: "100x100>"}

  STARS = [
    ["Рыбы",[20,2],[20,3]],
    ["Овен",[21,3],[20,4]],
    ["Телец",[21,4],[21,5]],
    ["Близнецы",[22,5],[21,6]],
    ["Рак",[22,6],[22,7]],
    ["Лев",[23,7],[23,8]],
    ["Дева",[24,8],[23,9]],
    ["Весы",[24,9],[23,10]],
    ["Скорпион",[24,10],[22,11]],
    ["Стрелец",[23,11],[21,12]],
    ["Козерог",[22,12],[20,1]],
    ["Водолей",[21,1],[19,2]]
  ]
  validates :name, presence: true
  validate :check_birthday
  validates_attachment :avatar, content_type: {content_type: /\Aimage\/.*\z/}

  has_and_belongs_to_many :films, -> { ordering.base }
  has_many :produced_films, -> { ordering.base }, class_name: 'Film', foreign_key: :director_id
  belongs_to :country

  scope :ordering, -> { (order(:name)) }
  scope :full, -> { includes(films: :genre, produced_films: :genre) }

  def zod
    res = STARS[0]
    STARS.each do |i|
      date1 = Date.new(birthday.year, i[1][1], i[1][0])
      date2 = Date.new(birthday.year, i[2][1], i[2][0])
      if birthday >= date1 && birthday <= date2
        res = i
      end
    end
    res
  end

  def self.edit_by?(u)
    u.try(:admin?)
  end

  def can_destroy?
    produced_films.blank? && films.blank?
  end

  def age(d = nil)
    d ||= Date.today
    return unless birthday
    res = d.year - birthday.year
    res -= 1 if Date.new(d.year, birthday.month, birthday.day) > d
    res
  end

  def dayperson(d = nil)
    d ||= Date.today
    return unless birthday
    if d.month == birthday.month && d.day == birthday.day
      res = 0
      res
    end
  end

  def human_age(d = nil)
    "#{age(d)} #{RuPropisju.choose_plural(age(d), 'год', 'года', 'лет')}"
  end

  def self.search(query)
    ordering.where("upper(name) like upper(:q) or upper(origin_name) like upper(:q)", q: "%#{query}%")
  end


  private
  def check_birthday
    errors.add(:birthday, :invalid) if birthday && birthday > Date.today
    true
  end
end
