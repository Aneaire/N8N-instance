#!/bin/bash

# HubSpot Lead Qualification System Setup Script

echo "🚀 Setting up HubSpot Lead Qualification System..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please update .env with your actual HubSpot credentials and other settings."
    echo "   Edit the file and then run this script again."
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p workflows
mkdir -p logs

# Start the containers
echo "🐳 Starting Docker containers..."
docker-compose up -d

# Wait for containers to be ready
echo "⏳ Waiting for containers to start..."
sleep 15

# Check if containers are running
if docker ps | grep -q "n8n"; then
    echo "✅ n8n container is running"
else
    echo "❌ n8n container failed to start"
    docker-compose logs n8n
    exit 1
fi

if docker ps | grep -q "redis"; then
    echo "✅ Redis container is running"
else
    echo "❌ Redis container failed to start"
    docker-compose logs redis
    exit 1
fi

# Display next steps
echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "📋 Next Steps:"
echo "1. Open your browser and go to: http://localhost:5678"
echo "2. Login with the credentials from your .env file"
echo "3. Import the workflows from the workflows/ directory:"
echo "   - hubspot-contact-data-collection.json"
echo "   - hubspot-batch-lead-scoring.json"
echo "4. Configure your HubSpot and SMTP credentials in n8n"
echo "5. Set up webhooks in your HubSpot account"
echo ""
echo "📖 For detailed instructions, see README.md"
echo ""
echo "🔧 Useful commands:"
echo "  - View logs: docker-compose logs -f"
echo "  - Stop system: docker-compose down"
echo "  - Restart: docker-compose restart"