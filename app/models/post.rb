class Post < ActiveRecord::Base

  # Callbacks
  before_save { self.name = normalize_name(name) }

  # Associations
  belongs_to :category
  belongs_to :user

  # Validations
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :price
  validates_presence_of :category
  validates_presence_of :user


  def normalize_name(name)
    name.to_s.capitalize.strip
  end
end
