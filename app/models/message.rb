require 'data_mapper'
require 'dm-validations'
require_relative '../data_mapper_setup'
require 'dm-postgres-adapter'


class Message
  include DataMapper::Resource

  property :id, Serial
  property :content, Text
  property :created_at, DateTime
  property :user, String

end