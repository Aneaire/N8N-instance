# HubSpot Custom Properties Setup

## Required Contact Properties

Create these custom properties in your HubSpot account:

### 1. Lead Score
- **Property Name**: `lead_score`
- **Label**: Lead Score
- **Type**: Number
- **Group**: Lead Intelligence
- **Description**: Automated lead score calculated by AI analysis

### 2. Intent Level
- **Property Name**: `intent_level`
- **Label**: Intent Level
- **Type**: Dropdown
- **Group**: Lead Intelligence
- **Options**: 
  - Low
  - Medium
  - High
- **Description**: Purchase intent classification

### 3. Last Scored Date
- **Property Name**: `last_scored_date`
- **Label**: Last Scored Date
- **Type**: Date
- **Group**: Lead Intelligence
- **Description**: Last time the lead was scored by the system

### 4. Score Change
- **Property Name**: `score_change`
- **Label**: Score Change
- **Type**: Number
- **Group**: Lead Intelligence
- **Description**: Change in lead score from last calculation

## Required Company Properties

### 1. Company Lead Score
- **Property Name**: `company_lead_score`
- **Label**: Company Lead Score
- **Type**: Number
- **Group**: Lead Intelligence
- **Description**: Aggregate score of all contacts in the company

### 2. Engagement Level
- **Property Name**: `engagement_level`
- **Label**: Engagement Level
- **Type**: Dropdown
- **Group**: Lead Intelligence
- **Options**:
  - Low
  - Medium
  - High
- **Description**: Overall company engagement level

## Setup Instructions

1. Go to HubSpot Settings → Properties → Contact Properties
2. Click "Create property"
3. Fill in the details for each property listed above
4. Repeat for Company Properties
5. Ensure the properties are visible in your contact and company views

## Webhook Configuration

Create a webhook subscription in HubSpot:

1. Go to Settings → Integrations → Webhooks
2. Click "Create subscription"
3. Select "Contact property change" events
4. Set target URL: `http://your-n8n-domain:5678/webhook/hubspot-webhook`
5. Select the custom properties above for monitoring
6. Save and activate the webhook

## API Permissions

Ensure your HubSpot private app has these scopes:
- `crm.objects.contacts.read`
- `crm.objects.contacts.write`
- `crm.objects.companies.read`
- `crm.objects.companies.write`
- `crm.objects.deals.read`
- `crm.objects.engagements.read`
- `crm.lists.read`
- `crm.lists.write`
- `crm.objects.owners.read`
- `crm.schemas.contacts.read`
- `crm.schemas.companies.read`