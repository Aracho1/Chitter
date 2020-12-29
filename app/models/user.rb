require 'bcrypt'
require './lib/db_connection'
require 'data_mapper'

class User
  include BCrypt
  include DataMapper::Resource
  attr_reader :id, :username, :name, :email, :password_hash

  def initialize(id:, username:, name:, email:, password:)
    @id = id
    @username = username
    @name = name
    @email = email
    @password_hash = password
  end

  def self.all
    result = DBConnection.query("SELECT * FROM users")
    result.map do |user|
      User.new(id:user['id'], username:user['username'], name:user['name'], email:user['email'], password:user['password'])
    end
  end

  def self.create(username:username, name:name, email:email, password:password)
    if find(email).nil? && !username_taken?(username)
      password_hash = Password.create(password)
      result = DBConnection.query("INSERT INTO users(username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password_hash}') RETURNING id, username, name, email, password")
      User.new(id: result[0]['id'], username: result[0]['username'], name:result[0]['name'], email:result[0]['email'], password:result[0]['password'])
    end
  end

  def self.find(email)
    result = DBConnection.query("SELECT * FROM users where email='#{email}'")
    return nil if result.count.zero?
    User.new(id:result[0]['id'], username:result[0]['username'], name:result[0]['name'], email:result[0]['email'], password:result[0]['password'])
  end

  def self.username_taken?(username)
    result = DBConnection.query("SELECT * FROM users where username='#{username}'")
    return false if result.count.zero?
    true
  end


  def self.authenticate(email, password)
    user = find(email)
    return nil unless user
    return nil unless user.password == password
    user
  end

  def password
    @password ||= Password.new(password_hash)
  end

end