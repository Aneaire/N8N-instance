# HubSpot AI Lead Qualification System Workflow

## Overview

This n8n workflow automates lead qualification and scoring using HubSpot CRM data and AI analysis to identify sales-ready leads. It processes contacts in real-time via webhooks and through scheduled batch processing, calculating purchase intent using multiple data points and sending automated sales alerts.

![HubSpot AI Lead Qualification Workflow](https://github.com/Aneaire/N8N-instance/blob/main/images/hubspot.png?raw=true)

## Workflow Architecture

### Dual Trigger System

#### 1. Real-time Processing (Webhook Trigger)
- **Type**: Webhook from HubSpot
- **Path**: `/hubspot-webhook`
- **Purpose**: Processes individual contacts when properties change
- **Frequency**: Event-driven, immediate response

#### 2. Batch Processing (Schedule Trigger)
- **Type**: Scheduled execution
- **Interval**: Every 6 hours
- **Purpose**: Processes all active contacts in bulk
- **Scope**: Comprehensive contact analysis

### Processing Flow

#### Real-time Path
1. **Webhook Trigger** → Receives contact property change notification
2. **Get Contact (Webhook)** → Fetches updated contact details via HubSpot API
3. **Get Engagements** → Retrieves contact engagement history
4. **Prepare AI Data** → Formats data for AI analysis
5. **Gemini AI Lead Scorer** → Calculates lead score and intent
6. **Process AI Response** → Formats AI analysis results
7. **Filter High-Intent Leads** → Routes high-intent leads to alerts
8. **Update Contact in HubSpot** → Saves new score and intent level
9. **Prepare Email Notification** → Formats sales alert email
10. **Send Sales Alert Email** → Delivers to sales team
11. **Webhook Response** → Confirms successful processing

#### Batch Path
1. **Schedule Trigger** → Runs every 6 hours
2. **Get Contacts (Batch)** → Fetches all contacts via HubSpot API
3. **Prepare AI Data** → Formats batch data for analysis
4. **Gemini AI Lead Scorer** → Analyzes all contacts
5. **Process AI Response** → Handles batch results
6. **Filter High-Intent Leads** → Identifies priority leads
7. **Update Contact in HubSpot** → Updates scores in bulk
8. **Prepare Email Notification** → Creates batch summary
9. **Send Sales Alert Email** → Sends comprehensive report

## AI Analysis Framework

### Advanced Lead Scoring Engine

The workflow uses Google Gemini AI with specialized tools for comprehensive lead analysis:

#### Core Analysis Tools
- **Company Research Tool**: Analyzes company background, size, industry, funding
- **Job Title Analyzer Tool**: Evaluates seniority level and decision-making authority
- **Behavioral Pattern Detector Tool**: Identifies micro-conversions and buying signals
- **Engagement Quality Scorer Tool**: Assesses interaction significance and quality
- **Temporal Analysis Tool**: Analyzes timing patterns and urgency indicators
- **Competitive Intelligence Tool**: Researches market position and competitors

#### Scoring Framework
- **Demographic Scoring**: Job seniority, company information
- **Behavioral Scoring**: Page views, visit frequency, specific page visits
- **Engagement Scoring**: Email interactions, meetings, calls, form submissions
- **Lifecycle Scoring**: Lead stage progression and qualification status
- **Intent Classification**: Low/Medium/High intent levels (80+ = High)

### Intent Levels
- **High Intent (80+ points)**: Immediate sales outreach recommended
- **Medium Intent (50-79 points)**: Nurture with targeted content
- **Low Intent (<50 points)**: Continue marketing automation

## Data Sources Analyzed

### Contact Information
- Job title and seniority level
- Company information and size
- Contact details and demographics

### Behavioral Data
- Page views and visit frequency
- Specific page visits (pricing, demo, contact)
- Time since last activity
- Digital engagement patterns

### Engagement Activities
- Email interactions and responses
- Meeting bookings and attendance
- Call activities and duration
- Form submissions and conversions

### Lifecycle Stages
- Lead status progression
- Marketing/sales qualification
- Customer journey stage

## Email Alert System

### Individual Lead Alerts
**Trigger**: Real-time when lead reaches high-intent status
**Content**:
- Lead details and contact information
- Calculated score and intent level
- Specific buying signals detected
- AI recommendations and next steps
- Confidence level and reasoning

### Batch Summary Reports
**Trigger**: Every 6 hours with new high-intent leads
**Content**:
- Count of new high-intent leads
- Detailed lead table with scores and signals
- Prioritized outreach recommendations
- Batch processing summary

## HubSpot Integration

### Required Custom Properties

#### Contact Properties
- `lead_score` (Number): Calculated lead score 0-100
- `intent_level` (Dropdown): Low/Medium/High classification
- `last_scored_date` (Date): Last scoring timestamp

#### Company Properties
- `company_lead_score` (Number): Aggregate contact scores
- `engagement_level` (Dropdown): Overall engagement classification

### API Permissions Required
- `crm.objects.contacts.read/write`
- `crm.objects.companies.read/write`
- `crm.objects.deals.read`
- `crm.objects.engagements.read`
- `crm.lists.read/write`

### Webhook Configuration
- **Event**: Contact property change
- **Properties**: Monitor lead_score, intent_level
- **Target URL**: `http://your-n8n-domain:5678/webhook/hubspot-webhook`

## Configuration

### Required Credentials

#### HubSpot API
- **Type**: Private App Token or API Key
- **Scopes**: CRM read/write permissions
- **Setup**: Add "HubSpot API" credential in n8n

#### SMTP Email
- **Type**: SMTP authentication
- **Purpose**: Send sales alerts and reports
- **Setup**: Add "SMTP" credential with provider settings

### Environment Variables
```bash
HUBSPOT_PRIVATE_APP_TOKEN=your_private_app_token
HUBSPOT_API_KEY=your_api_key
SALES_EMAIL=sales@company.com
```

## Technical Implementation

### Node Types Used
- **Webhook**: Receives HubSpot notifications
- **Schedule Trigger**: Runs batch processing
- **HTTP Request**: HubSpot API integration
- **Code**: Data transformation and logic
- **Google Gemini**: AI analysis with custom tools
- **If**: Conditional routing for high-intent leads
- **Email Send**: Alert delivery
- **Respond to Webhook**: Confirmation responses

### Data Processing Logic

#### Contact Filtering (Batch Mode)
- Skips contacts with scores ≥80 (already high-intent)
- Processes remaining contacts for re-scoring
- Focuses on warm and cold leads for optimization

#### Score Change Tracking
- Compares new vs. existing scores
- Tracks score improvement trends
- Identifies leads moving toward high-intent

#### Engagement Analysis
- Weights different engagement types
- Considers recency and frequency
- Evaluates interaction quality vs. quantity

## Performance & Scaling

### Processing Capacity
- **Real-time**: Individual contact processing (fast response)
- **Batch**: Bulk processing with filtering (efficient scaling)
- **Memory**: Optimized for large contact databases

### Error Handling
- **API Limits**: Respects HubSpot rate limits
- **Failed Updates**: Logs errors without stopping workflow
- **Webhook Retries**: Handles temporary connectivity issues

### Monitoring
- **Execution Logs**: Track processing success/failure
- **Score Distribution**: Monitor lead quality trends
- **Alert Frequency**: Track sales team notification volume

## Customization Options

### Scoring Logic
Modify the AI analysis prompts and tools to:
- Adjust point values for different activities
- Add new scoring criteria
- Change intent level thresholds
- Customize industry-specific factors

### Email Templates
Update the email preparation nodes to:
- Change styling and branding
- Add company logos and colors
- Modify content sections
- Customize alert thresholds

### Processing Frequency
Adjust the schedule trigger to:
- Change batch processing intervals
- Add more frequent real-time checks
- Implement priority-based processing

## Security Considerations

- **API Tokens**: Secure storage in n8n credentials
- **Data Privacy**: HubSpot data handling compliance
- **Access Control**: Restricted n8n user access
- **Audit Logging**: Track all lead scoring changes

## Usage Examples

### Real-time Alert Scenario
```
Contact: john@techcorp.com
Trigger: Property change (new demo page visit)
Process: Score increases from 45 to 82
Result: High-intent email sent to sales team
Action: Immediate outreach recommended
```

### Batch Processing Scenario
```
Input: 500 contacts processed
Results: 12 new high-intent leads identified
Output: Batch summary email with prioritized list
Impact: Sales team focuses on highest-potential leads
```

## Dependencies

- **n8n**: Version 1.122.4 or compatible
- **HubSpot**: Professional/Enterprise plan with API access
- **Google Gemini**: API access configured
- **SMTP Service**: Email delivery capability

## Related Files

- **Workflow JSON**: `hubspot-ai-lead-qualification.json`
- **Setup Guide**: `HUBSPOT_SETUP.md`
- **Environment Config**: `.env`
- **Custom Properties**: `HUBSPOT_SETUP.md` (properties section)

## Maintenance & Troubleshooting

### Regular Tasks
- Monitor webhook delivery success rates
- Review scoring accuracy with sales team
- Update email recipient lists
- Rotate API credentials periodically

### Common Issues
- **Webhook failures**: Verify HubSpot webhook configuration
- **API authentication**: Check token validity and scopes
- **Scoring accuracy**: Calibrate AI analysis prompts
- **Email delivery**: Verify SMTP settings and spam filters

### Performance Optimization
- Adjust batch processing frequency
- Implement contact filtering logic
- Monitor API usage and limits
- Optimize AI analysis parameters