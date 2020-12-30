require 'bcrypt'
require 'active_record'

class User < ActiveRecord::Base
  include BCrypt

  has_many :messages
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..20 }

  # attr_reader :password
  # attr_accessor :password_confirmation

  # property :id, Serial
  # property :username, String, required: true, unique: true
  # property :name, String, required: true
  # property :email, String, required: true, :format => :email_address, unique: true
  # property :password_digest, Text


  def self.authenticate(email, password)
    user = first(email: email)
    user && Password.new(user.password_digest) == password ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end


end