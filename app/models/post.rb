class Post < ActiveRecord::Base
  # Associations
  belongs_to :category

  # Validations
  validates_presence_of :name
  validates_presence_of :content
  validates_presence_of :price
end
