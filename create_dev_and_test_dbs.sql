CREATE ROLE telegram WITH LOGIN PASSWORD 'telegram'  CREATEDB;

CREATE DATABASE telegram_development;
CREATE DATABASE telegram_test;

GRANT ALL PRIVILEGES ON DATABASE "telegram_development" to telegram;
GRANT ALL PRIVILEGES ON DATABASE "telegram_test" to telegram;
