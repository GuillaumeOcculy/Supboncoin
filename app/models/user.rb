class User < ActiveRecord::Base
  has_secure_password

  # Validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :password

  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :phone

  # Methods
  def self.by_letter(letter)
    where('last_name LIKE ?', "#{letter}%").order(:last_name)
  end
end
