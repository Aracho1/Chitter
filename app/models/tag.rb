require './lib/db_connection'

class Tag
  attr_reader :id, :message_id, :user_id

  def initialize(id, message_id, user_id)
    @id = id
    @message_id = message_id
    @user_id = user_id
  end

  def self.create(message_id, user_id)
    result = DBConnection.query("INSERT INTO tag(message_id, user_id) VALUES(#{message_id}, #{user_id}) RETURNING id, message_id, user_id")
    Tag.new(result[0]['id'], result[0]['message_id'], result[0]['user_id'])
  end

  def self.find(message_id)
    DBConnection.query("SELECT * FROM tag WHERE message_id=#{message_id}")[0]['user_id']
  end

end