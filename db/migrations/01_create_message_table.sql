CREATE TABLE IF NOT EXISTS messages (id SERIAL PRIMARY KEY, content VARCHAR(240), created_at TIMESTAMPTZ NOT NULL DEFAULT NOW());
