# rallymate-database

Docker-based PostgreSQL database server for Rallymate services, optimized for economical GCP deployment.

## Quick Start

1. **Setup environment**:
   ```bash
   cp .env.example .env
   # Edit .env and set your POSTGRES_PASSWORD
   ```

2. **Start the database**:
   ```bash
   docker-compose up -d
   ```

3. **Stop the database**:
   ```bash
   docker-compose down
   ```

## Database Configuration

- **User**: `rallymate`
- **Database**: `rallymate`
- **Port**: `5432`
- **Image**: PostgreSQL 16 (official)

## GORM Connection (Go Services)

Use this connection string in your Go applications with GORM:

```go
dsn := "host=localhost user=rallymate password=YOUR_PASSWORD dbname=rallymate port=5432 sslmode=disable TimeZone=UTC"
db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
```

For production/GCP deployment, replace `localhost` with your database host.

## GCP Deployment

### Option 1: Compute Engine VM
- Deploy this Docker setup on a small VM (e.g., e2-micro for development)
- Use persistent disks for data storage
- Configure firewall rules for port 5432

### Option 2: Cloud Run (for development/testing)
- Suitable for non-persistent testing environments
- Very cost-effective for intermittent usage

### Production Considerations
- Consider migrating to Cloud SQL for PostgreSQL for production workloads
- Implement proper backup strategies
- Use Cloud IAM for authentication instead of passwords

## Health Check

The service includes a health check that verifies PostgreSQL is ready to accept connections.

## Data Persistence

PostgreSQL data is stored in a Docker volume named `pgdata` for persistence across container restarts.

## Security Notes

- Always use strong passwords
- In production, consider using Cloud SQL Auth Proxy or VPC peering
- Never commit `.env` files to version control
