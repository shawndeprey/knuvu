class User < ActiveRecord::Base
  #include Tire::Model::Search
  #include Tire::Model::Callbacks
  nilify_blanks
  #after_touch() { tire.update_index }

=begin
  settings :analysis => SearchHelper.search_ahead_analysis do
    mapping {
      indexes :id,                  :index => :no
      indexes :title,               :index => :no
      indexes :full_name,           :type => 'string', :boost => 2.0, :search_analyzer => "typeahead_search", :index_analyzer => "typeahead_index"
      indexes :email,               :type => 'string', :search_analyzer => "typeahead_search", :index_analyzer => "typeahead_index"
    }
  end
=end

  class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        record.errors[attribute] << (options[:message] || "is not an email")
      end
    end
  end

  # Attributes full_name, email, phone, password, reset_hash, verified, admin, created_at, updated_at

  # File Attachments using Paperclip and resized with ImageMagick
  has_attached_file :avatar, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>" }

  validates_length_of :password, minimum: 8, maximum: 31, presence: true
  validates :full_name, presence: true
  validates :email, uniqueness: true, email: true

  before_save :encrypt_password
  after_destroy :clean_dependents

  def encrypt_password
    unless self.password.length == 32
      self.password = ApplicationHelper::md5(self.password)
    end
  end

  def clean_dependents
    # Destroy all models that wont destroy themselves here. Leave no stragglers or islands!
  end
end