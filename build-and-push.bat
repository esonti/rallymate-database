@echo off
REM Build and Push Script for RallyMate Database to GCP Artifact Registry

setlocal EnableDelayedExpansion

REM Configuration - Update these values for your environment
set PROJECT_ID=rallymate-sonti
set REGION=us-central1
set REPOSITORY=rallymate-repo
set IMAGE_NAME=rallymate-database

REM Use provided tag or default to 'latest'
if "%1"=="" (
    set TAG=latest
) else (
    set TAG=%1
)

REM Full image name
set FULL_IMAGE_NAME=%REGION%-docker.pkg.dev/%PROJECT_ID%/%REPOSITORY%/%IMAGE_NAME%:%TAG%

echo Building Docker image for RallyMate Database...
echo Image: %FULL_IMAGE_NAME%

REM Build the Docker image
docker build -t "%FULL_IMAGE_NAME%" .

if %ERRORLEVEL% neq 0 (
    echo Failed to build Docker image
    exit /b 1
)

echo Docker image built successfully!

REM Authenticate with GCP (if not already done)
echo Configuring Docker for Artifact Registry...
gcloud auth configure-docker %REGION%-docker.pkg.dev --quiet

if %ERRORLEVEL% neq 0 (
    echo Failed to configure Docker authentication
    exit /b 1
)

REM Push the image
echo Pushing image to Artifact Registry...
docker push "%FULL_IMAGE_NAME%"

if %ERRORLEVEL% neq 0 (
    echo Failed to push image
    exit /b 1
)

echo Database image pushed successfully!
echo Full image name: %FULL_IMAGE_NAME%

endlocal
