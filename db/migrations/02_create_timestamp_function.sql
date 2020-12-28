CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.created_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION
chitter=# CREATE TRIGGER set_timestamp
BEFORE UPDATE ON messages
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();