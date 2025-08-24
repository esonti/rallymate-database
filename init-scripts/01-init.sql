-- Initial database setup for Rallymate
-- This script runs automatically when the container starts for the first time

-- Create extensions that might be useful for the application
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Set timezone to UTC for consistency
SET timezone = 'UTC';

-- Create a basic healthcheck function
CREATE OR REPLACE FUNCTION healthcheck() 
RETURNS TEXT AS $$
BEGIN
    RETURN 'Rallymate Database is healthy';
END;
$$ LANGUAGE plpgsql;
