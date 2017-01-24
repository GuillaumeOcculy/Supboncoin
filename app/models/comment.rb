class Comment < ActiveRecord::Base

  # Associations
  belongs_to :post
  belongs_to :user

  # Validations
  validates_presence_of :body
  validates_presence_of :user_id
  validates_presence_of :post_id

  # Scopes
  scope :recent, -> { order(created_at: :desc)}
  
end
