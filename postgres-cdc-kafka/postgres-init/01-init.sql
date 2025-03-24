-- Create the debezium user
CREATE USER debezium WITH REPLICATION PASSWORD 'debezium';

-- Grant privileges to the debezium user on the phoenix database
GRANT ALL PRIVILEGES ON DATABASE phoenix TO debezium;

-- Connect to the phoenix database
\c phoenix

-- Grant schema privileges to debezium
GRANT USAGE ON SCHEMA public TO debezium;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO debezium;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO debezium;

-- Create a sample table for CDC
CREATE TABLE shifts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

-- Configure the table for CDC
ALTER TABLE shifts REPLICA IDENTITY FULL;

-- Create a publication for Debezium
CREATE PUBLICATION debezium_pub FOR TABLE shifts;
