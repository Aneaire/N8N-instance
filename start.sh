#!/bin/bash
set -e

# Railway deployment script for n8n
echo "🚀 Starting n8n deployment on Railway..."

# Railway-specific environment variables
export PORT=${PORT:-5678}
export N8N_HOST=${N8N_HOST:-0.0.0.0}
export N8N_PORT=$PORT
export N8N_PROTOCOL=${N8N_PROTOCOL:-http}

# Authentication (Railway environment variables)
export N8N_BASIC_AUTH_ACTIVE=${N8N_BASIC_AUTH_ACTIVE:-true}
export N8N_BASIC_AUTH_USER=${N8N_BASIC_AUTH_USER:-${RAILWAY_PROJECT_NAME:-admin}}
export N8N_BASIC_AUTH_PASSWORD=${N8N_BASIC_AUTH_PASSWORD:-${RAILWAY_PROJECT_NAME:-password}}

# Database configuration for Railway PostgreSQL
if [ -n "$DATABASE_URL" ]; then
    echo "📊 Configuring PostgreSQL database..."
    export DB_TYPE=postgres
    export DB_POSTGRESDB_URL="$DATABASE_URL"
    export DB_POSTGRESDB_SSL=true
fi

# Redis configuration for Railway Redis
if [ -n "$REDIS_URL" ]; then
    echo "🔄 Configuring Redis queue..."
    export QUEUE_BULL_REDIS_URL="$REDIS_URL"
fi

# Webhook URL configuration
if [ -n "$RAILWAY_STATIC_URL" ]; then
    export WEBHOOK_URL="$RAILWAY_STATIC_URL"
    echo "🔗 Webhook URL: $WEBHOOK_URL"
elif [ -n "$RAILWAY_PROJECT_NAME" ]; then
    export WEBHOOK_URL="https://$RAILWAY_PROJECT_NAME.up.railway.app"
    echo "🔗 Webhook URL: $WEBHOOK_URL"
fi

# Security and performance settings
export N8N_SECURE_COOKIE_HTTP_ONLY=true
export N8N_BLOCK_ENV_ACCESS_IN_NODE=false
export N8N_RUNNERS_ENABLED=true
export N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Disable telemetry in production
export N8N_DIAGNOSTICS_ENABLED=false

# Create necessary directories
echo "📁 Creating n8n directories..."
mkdir -p /app/.n8n/workflows
mkdir -p /app/.n8n/storage

# Copy workflows if they exist
if [ -d "/app/workflows" ]; then
    echo "📋 Copying workflows..."
    cp -r /app/workflows/* /app/.n8n/workflows/ 2>/dev/null || true
fi

# Health check
echo "🏥 Running health checks..."
npm list n8n || echo "Warning: n8n not found in node_modules"

echo "🎯 Starting n8n server on port $PORT..."
echo "📱 n8n will be available at: http://localhost:$PORT"
echo "🌐 External URL: $WEBHOOK_URL"

# Start n8n
exec n8n start