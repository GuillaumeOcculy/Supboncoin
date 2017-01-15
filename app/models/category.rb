class Category < ActiveRecord::Base

  # Callbacks
  before_save { self.name = normalize_name(name)  }

  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name

  # Instance Methods
  def normalize_name(name)
    name.to_s.gsub(/\s+/, "").titleize
  end

end
