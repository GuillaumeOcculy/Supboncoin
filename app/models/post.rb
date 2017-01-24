class Post < ActiveRecord::Base

  # Callbacks
  before_save { self.name = normalize_name(name) }

  # Associations
  belongs_to :category
  belongs_to :user
  has_many :comments

  # Validations
  validates_presence_of :name
  validates_presence_of :description
  validates             :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates_presence_of :category
  validates_presence_of :user

  # Scopes
  scope :recent, -> { order(created_at: :desc)}

  # Class Methods
  def self.by_name(name)
    where('name LIKE ?', "%#{name}%").order(:created_at)
  end

  # Instance Methods
  def normalize_name(name)
    name.to_s.capitalize.strip
  end
end
