-- Lightweight health objects for monitoring/checks

CREATE SCHEMA IF NOT EXISTS gitnut;
CREATE TABLE IF NOT EXISTS gitnut.healthcheck (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz NOT NULL DEFAULT now()
);

INSERT INTO gitnut.healthcheck DEFAULT VALUES;
