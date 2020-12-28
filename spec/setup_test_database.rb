require 'pg'
p "Setting up the test database..."

def wipe_clean
  @connection = PG.connect(dbname: 'chitter_test')
  @connection.exec("TRUNCATE messages;")
  @connection.exec("TRUNCATE users CASCADE;")
end
