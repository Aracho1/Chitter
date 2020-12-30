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
  # attr_reader :id, :username, :name, :email, :password_hash
  attr_reader :password
  attr_accessor :password_confirmation

  property :id, Serial
  property :username, String, required: true, unique: true
  property :name, String, required: true
  property :email, String, required: true, :format => :email_address, unique: true
  property :password_digest, Text

  # def initialize(id:, username:, name:, email:, password:)
  #   @id = id
  #   @username = username
  #   @name = name
  #   @email = email
  #   @password_hash = password
  # end

  # def self.all
  #   result = DBConnection.query("SELECT * FROM users")
  #   result.map do |user|
  #     User.new(id:user['id'], username:user['username'], name:user['name'], email:user['email'], password:user['password'])
  #   end
  # end

  # def self.create(username:username, name:name, email:email, password:password)
  #   if find(email).nil? && !username_taken?(username)
  #     password_hash = Password.create(password)
  #     result = DBConnection.query("INSERT INTO users(username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password_hash}') RETURNING id, username, name, email, password")
  #     User.new(id: result[0]['id'], username: result[0]['username'], name:result[0]['name'], email:result[0]['email'], password:result[0]['password'])
  #   end
  # end

  # def self.find(email)
  #   result = DBConnection.query("SELECT * FROM users where email='#{email}'")
  #   return nil if result.count.zero?
  #   User.new(id:result[0]['id'], username:result[0]['username'], name:result[0]['name'], email:result[0]['email'], password:result[0]['password'])
  # end

  # def self.username_taken?(username)
  #   result = DBConnection.query("SELECT * FROM users where username='#{username}'")
  #   return false if result.count.zero?
  #   true
  # end


  def self.authenticate(email, password)
    user = first(email: email)
    # return nil unless user
    # return nil unless user.password == password
    user && Password.new(user.password_digest) == password ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = Password.create(password)
  end

  validates_confirmation_of :password

end

# DataMapper.finalize
# User.auto_upgrade!