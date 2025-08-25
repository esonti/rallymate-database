#!/bin/bash

# Build and Push Script for RallyMate Database to GCP Artifact Registry

set -e

# Configuration - Update these values for your environment
PROJECT_ID="rallymate-sonti"
REGION="us-central1"  # Change to your preferred region
REPOSITORY="rallymate-repo"
IMAGE_NAME="rallymate-database"
TAG="${1:-latest}"  # Use provided tag or default to 'latest'

# Full image name
FULL_IMAGE_NAME="${REGION}-docker.pkg.dev/${PROJECT_ID}/${REPOSITORY}/${IMAGE_NAME}:${TAG}"

echo "Building Docker image for RallyMate Database..."
echo "Image: ${FULL_IMAGE_NAME}"

# Build the Docker image
docker build -t "${FULL_IMAGE_NAME}" .

echo "Docker image built successfully!"

# Authenticate with GCP (if not already done)
echo "Configuring Docker for Artifact Registry..."
gcloud auth configure-docker "${REGION}-docker.pkg.dev" --quiet

# Push the image
echo "Pushing image to Artifact Registry..."
docker push "${FULL_IMAGE_NAME}"

echo "Database image pushed successfully!"
echo "Full image name: ${FULL_IMAGE_NAME}"

# Optional: Clean up local image to save space
# docker rmi "${FULL_IMAGE_NAME}"
