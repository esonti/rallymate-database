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

-- ======================================
-- Database Setup Only
-- ======================================
-- Note: Table schemas are managed by GORM AutoMigrate
-- This file only contains database-level setup

-- Function to update the updated_at column (used by GORM)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ======================================
-- Initial Data (Post-Migration)
-- ======================================
-- This data will be inserted after GORM creates the tables

-- Note: These INSERT statements will be executed by the application
-- after GORM AutoMigrate completes, not here in the init script
