require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'aracho',
  password: 'password',
  database: 'chitter_development'
)

class Message < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content, :created_at, :user
  # property :id, Serial
  # property :content, Text
  # property :created_at, DateTime
  # property :user, String

end