class User < ActiveRecord::Base
  has_secure_password

  # Callbacks
  before_save { self.email = normalize_email(email)  }
  before_save { self.username = normalize_username(username)  }

  # Associations
  has_many :posts

  # Validations
  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password, on: :create

  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_uniqueness_of :phone, allow_nil: true

  validates_format_of :email, with: /\A\d+@(supinfo).com\z/

  # Class Methods
  def self.by_letter(letter)
    where('last_name LIKE ?', "#{letter}%").order(:last_name)
  end

  # Instance Methods
  def normalize_email(email)
    email.to_s.downcase.gsub(/\s+/, "")
  end

  def normalize_username(username)
    username.to_s.downcase.gsub(/\s+/, "")
  end

  # Methods
  def name
    "#{first_name} #{last_name}"
  end
end
