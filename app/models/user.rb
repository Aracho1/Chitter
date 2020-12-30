require 'bcrypt'
# require './lib/db_connection'
require 'data_mapper'
require 'dm-validations'
require_relative '../data_mapper_setup'
require 'dm-postgres-adapter'
# require 'dm-sqlite-adapter'

class User
  include BCrypt
  include DataMapper::Resource

  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :username, String, required: true, unique: true
  property :name, String, required: true
  property :email, String, required: true, :format => :email_address, unique: true
  property :password_digest, Text


  def self.authenticate(email, password)
    user = first(email: email)
    user && Password.new(user.password_digest) == password ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  validates_confirmation_of :password

end