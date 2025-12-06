# N8N AI Sales Workflows

This repository contains n8n workflow automation setup with AI-powered sales workflows for HubSpot lead qualification and Fireflies meeting intelligence.

## 🚀 Live Instance

**🌐 Production URL:** [https://n8n-instance-production-9885.up.railway.app](https://n8n-instance-production-9885.up.railway.app)

## 🤖 Available Workflows

### 1. HubSpot AI Lead Qualification System
Automates lead qualification and scoring using HubSpot data and AI analysis to identify sales-ready leads.

📖 **[Complete Documentation](documentation/hubspot-ai-lead-qualification.md)**

### 2. Fireflies AI Sales Meeting Intelligence
Automatically analyzes sales meeting transcripts from Fireflies.ai using AI and sends intelligent email summaries to your sales team.

📖 **[Complete Documentation](documentation/fireflies-ai-sales-meeting-intelligence.md)**

## 🚀 Quick Start

1. **Access n8n**: Visit [https://n8n-instance-production-9885.up.railway.app](https://n8n-instance-production-9885.up.railway.app)
2. **Import Workflows**: Import the JSON files from the `workflows/` directory
3. **Configure Credentials**: Set up API keys for HubSpot, Fireflies, and email services
4. **Follow Setup Guides**: Use the detailed documentation linked above

## 📁 Repository Structure

```
├── workflows/                    # n8n workflow JSON files
│   ├── hubspot-ai-lead-qualification.json
│   └── fireflies-ai-sales-meeting-intelligence.json
├── documentation/               # Detailed workflow documentation
│   ├── hubspot-ai-lead-qualification.md
│   └── fireflies-ai-sales-meeting-intelligence.md
├── FIREFLIES_SETUP.md          # Fireflies integration setup
├── HUBSPOT_SETUP.md            # HubSpot integration setup
├── docker-compose.yml          # Local development setup
├── package.json               # Railway deployment config
├── railway.toml              # Railway configuration
└── start.sh                  # Railway startup script
```

## 📚 Documentation

For complete setup instructions and detailed workflow documentation, see:

- **[HubSpot AI Lead Qualification Setup](HUBSPOT_SETUP.md)**
- **[Fireflies AI Sales Meeting Intelligence Setup](FIREFLIES_SETUP.md)**
- **[HubSpot Workflow Documentation](documentation/hubspot-ai-lead-qualification.md)**
- **[Fireflies Workflow Documentation](documentation/fireflies-ai-sales-meeting-intelligence.md)**

## 🛠️ Local Development

For local development and testing:

```bash
# Clone repository
git clone https://github.com/Aneaire/N8N-instance.git
cd N8N-instance

# Start with docker-compose
docker-compose up -d

# Access at http://localhost:5678
```

## 📞 Support

For issues with:
- **HubSpot API**: Check HubSpot developer documentation
- **Fireflies API**: Check Fireflies developer documentation
- **n8n workflows**: Review n8n community forums
- **Railway deployment**: Check Railway documentation
- **Custom logic**: Consult the workflow execution logs