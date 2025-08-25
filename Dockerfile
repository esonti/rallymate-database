# Production Dockerfile for RallyMate Database
FROM postgres:15-alpine

# Install additional tools
RUN apk add --no-cache curl

# Create app directory and set permissions
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Set default environment variables
ENV POSTGRES_DB=rallymate
ENV POSTGRES_USER=rallymate
# POSTGRES_PASSWORD will be set via environment variable from secrets

# Expose PostgreSQL port
EXPOSE 5432

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB || exit 1

# Use the default postgres entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]
