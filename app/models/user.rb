class User < ActiveRecord::Base

  # Validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :phone
end
