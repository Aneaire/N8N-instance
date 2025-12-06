# HubSpot Lead Qualification System

This system automates lead qualification and scoring using HubSpot data and AI analysis to identify sales-ready leads.

## 🚀 Features

- **Real-time Lead Scoring**: Automatically scores contacts based on behavior and demographics
- **AI-Powered Analysis**: Calculates purchase intent using multiple data points
- **Automated Sales Alerts**: Notifies sales team when leads are ready for outreach
- **Batch Processing**: Regularly updates scores for all active contacts
- **Customizable Scoring**: Adaptable scoring logic based on your business needs

## 📊 Data Points Analyzed

### Contact Information
- Job title and seniority level
- Company information
- Contact details

### Behavioral Data
- Page views and visit frequency
- Specific page visits (pricing, demo, contact)
- Time since last activity
- Engagement patterns

### Engagement Activities
- Email interactions
- Meeting bookings
- Call activities
- Form submissions

### Lifecycle Stages
- Lead status progression
- Marketing/sales qualification
- Customer journey stage

## 🛠️ Setup Instructions

### 1. Configure Environment Variables

Copy the example environment file and update with your credentials:

```bash
cp .env.example .env
```

Update `.env` with your actual values:
- `HUBSPOT_PRIVATE_APP_TOKEN`: Your HubSpot private app token
- `HUBSPOT_API_KEY`: Your HubSpot API key
- `N8N_USER`: n8n username
- `N8N_PASSWORD`: n8n password
- `SALES_EMAIL`: Your sales team email address

### 2. Start the System

```bash
docker-compose up -d
```

### 3. Access n8n

Open your browser and navigate to: `http://localhost:5678`

Login with the credentials you set in the environment file.

### 4. Import Workflow

1. In n8n, go to "Workflows" → "Import from file"
2. Import the single workflow file: `hubspot-ai-lead-qualification.json`

**Important**: This single workflow combines all functionality using HTTP Request nodes to avoid compatibility issues.

### 5. Configure Credentials

In n8n, set up the following credentials:

#### HubSpot API
- Go to Settings → Credentials
- Add "HubSpot API" credential
- Use your private app token or API key

#### SMTP Email
- Add "SMTP" credential for sending sales alerts
- Configure with your email provider settings

### 6. Set Up HubSpot Webhooks

1. In your HubSpot account, go to Settings → Integrations → Webhooks
2. Create a new webhook subscription
3. Subscribe to "Contact property change" events
4. Set the target URL to: `http://your-n8n-domain:5678/webhook/hubspot-webhook`
5. Replace `your-n8n-domain` with your actual n8n domain

### 7. Create Custom HubSpot Properties

In HubSpot, create these custom contact properties:
- `lead_score` (Number field): Stores the calculated lead score
- `intent_level` (Text field): Low/Medium/High intent classification
- `last_scored_date` (Date field): Last time the lead was scored

## 🎯 Scoring Logic

### Demographic Scoring
- Executive titles (VP, C-level): +25 points
- Manager/Director titles: +15 points
- Company information provided: +10 points

### Behavioral Scoring
- High page views (>10): +20 points
- Multiple visits (>5): +15 points
- Pricing/demo page visits: +25 points
- Contact/enterprise page visits: +20 points

### Engagement Scoring
- Meeting scheduled: +30 points
- Call activity: +20 points
- Email engagement: +10 points

### Lifecycle Scoring
- Marketing Qualified Lead: +25 points
- Sales Qualified Lead: +40 points

### Intent Levels
- **High Intent** (80+ points): Immediate sales outreach recommended
- **Medium Intent** (50-79 points): Nurture with targeted content
- **Low Intent** (<50 points): Continue marketing automation

## 🔄 Workflow Description

### HubSpot AI Lead Qualification System

**Single comprehensive workflow with dual triggers:**

#### Real-time Processing (Webhook Trigger)
- **Trigger**: Webhook from HubSpot when contact properties change
- **Process**: 
  1. Retrieves updated contact details via HTTP API
  2. Fetches engagement history via HTTP API
  3. Calculates lead score using AI logic
  4. Updates contact in HubSpot with new score via HTTP API
  5. Sends immediate email alert to sales team for high-intent leads

#### Batch Processing (Schedule Trigger)
- **Trigger**: Runs every 6 hours automatically
- **Process**:
  1. Gets all contacts from HubSpot via HTTP API
  2. Calculates scores for all contacts (skipping already high-scoring ones)
  3. Updates scores in HubSpot via HTTP API
  4. Sends batch email summary of new high-intent leads

#### AI Scoring Engine
- **Demographic Analysis**: Job titles, company information
- **Behavioral Scoring**: Page views, visit frequency, specific page visits
- **Engagement Tracking**: Emails, meetings, calls, form submissions
- **Lifecycle Progression**: MQL/SQL status, lead stage changes
- **Intent Classification**: Low/Medium/High intent levels (80+ = High)

## 📧 Email Alerts

### Individual Lead Alerts
Sent immediately when a lead reaches high-intent status:
- Lead details and contact information
- Calculated score and intent level
- Specific buying signals detected
- Recommended actions

### Batch Summary Reports
Sent every 6 hours with:
- Count of new high-intent leads
- Detailed lead table with scores and signals
- Prioritized outreach recommendations

## 🎛️ Customization

### Modifying Scoring Logic
Edit the "Calculate Lead Score" code nodes in the workflows to adjust:
- Point values for different activities
- New scoring criteria
- Intent level thresholds

### Adding New Data Sources
Extend the workflows to include:
- Website analytics data
- CRM integration
- Third-party enrichment data
- Custom event tracking

### Customizing Email Templates
Modify the email nodes to match your brand:
- Update email templates
- Add company branding
- Include additional lead data
- Customize recommended actions

## 🔍 Monitoring and Maintenance

### Check Workflow Status
- Monitor n8n workflow execution logs
- Review error handling and retry logic
- Track webhook delivery success rates

### Performance Optimization
- Adjust batch processing frequency
- Optimize API call usage
- Monitor HubSpot API limits

### Data Quality
- Regularly review scoring accuracy
- Collect feedback from sales team
- Refine scoring models based on conversion data

## 🛡️ Security Considerations

- Store API credentials securely in n8n
- Use HTTPS for webhook endpoints
- Implement proper access controls
- Regularly rotate API keys
- Monitor for unusual activity

## 📈 Scaling the System

### High Volume Processing
- Implement queue-based processing
- Use Redis for caching (included in setup)
- Consider horizontal scaling for n8n

### Advanced AI Integration
- Integrate machine learning models
- Implement predictive scoring
- Add natural language processing for lead analysis

## 🆘 Troubleshooting

### Common Issues
1. **Webhook not triggering**: Check HubSpot webhook configuration and URL
2. **API authentication errors**: Verify HubSpot credentials in n8n
3. **Email not sending**: Check SMTP configuration and credentials
4. **Low scoring accuracy**: Review and adjust scoring logic

### Debug Mode
Enable debug logging in n8n workflows to trace issues and optimize performance.

## 📞 Support

For issues with:
- **HubSpot API**: Check HubSpot developer documentation
- **n8n workflows**: Review n8n community forums
- **Custom logic**: Consult the workflow execution logs