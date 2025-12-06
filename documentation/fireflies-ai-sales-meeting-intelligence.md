# Fireflies AI Sales Meeting Intelligence Workflow

## Overview

This n8n workflow automatically analyzes sales meeting transcripts from Fireflies.ai using AI and sends intelligent email summaries to your sales team. It processes meetings in real-time when they complete, extracting actionable sales intelligence without storing any data permanently.

![Fireflies AI Sales Meeting Intelligence Workflow](https://raw.githubusercontent.com/Aneaire/N8N-instance/main/images/fireflies.png)

## Workflow Architecture

### Trigger
- **Type**: Webhook from Fireflies.ai
- **Path**: `/fireflies-meeting-webhook`
- **Purpose**: Receives real-time notifications when meetings complete

### Processing Flow

1. **Webhook Trigger** → Receives meeting completion notification
2. **Get Recent Meetings** → Fetches meetings from last 24 hours via Fireflies GraphQL API
3. **Extract Meetings Array** → Parses GraphQL response into usable format
4. **Loop Over Meetings** → Processes each meeting individually
5. **Get Meeting Transcript** → Retrieves full transcript and metadata for each meeting
6. **Format Transcript Data** → Converts transcript into format suitable for AI analysis
7. **Gemini AI Sales Analysis** → Analyzes transcript for sales intelligence
8. **Prepare Email Data** → Formats analysis into professional HTML email
9. **Send Sales Intelligence Email** → Delivers report to sales team
10. **Webhook Response** → Confirms successful processing

## AI Analysis Capabilities

The workflow uses Google Gemini AI to extract comprehensive sales intelligence:

### Sales Intelligence Extracted
- **Deal Status**: Current stage (prospecting, qualification, proposal, negotiation, closing, won, lost)
- **Close Probability**: 0-100% likelihood of closing
- **Buying Signals**: Specific interest indicators and positive buying behavior
- **Objections**: Concerns, blockers, and competitor mentions
- **Action Items**: Commitments and follow-up tasks identified
- **Sentiment Analysis**: Overall meeting tone (positive/neutral/negative)
- **Key Topics**: Main discussion points and product interests
- **Decision Makers**: Key stakeholders and their roles
- **Recommendations**: Specific sales actions and urgency levels

## Email Output

### Subject Format
```
🚀 Sales Meeting: [Meeting Title] - [Deal Status] ([Probability]% probability)
```

### Email Sections
- **Meeting Overview**: Title, participants, duration, date
- **Deal Status & Probability**: Current stage with color-coded probability
- **Buying Signals**: ✅ Green section highlighting positive indicators
- **Objections & Concerns**: ⚠️ Red section listing blockers
- **Action Items**: 📋 Orange section with commitments
- **AI Recommendations**: 🎯 Purple section with next steps and urgency
- **Key Topics**: 💬 Teal section with discussion points

## Configuration

### Required Credentials

#### Fireflies API
- **Type**: API Key authentication
- **Purpose**: Access Fireflies meeting data and transcripts
- **Setup**: Add "Fireflies API" credential in n8n with your API key

#### SMTP Email
- **Type**: SMTP authentication
- **Purpose**: Send email reports to sales team
- **Setup**: Add "SMTP" credential with your email provider settings

### Email Recipients
Configure in the "Sales Team Email Configuration" node:
```json
{
  "salesTeamEmails": "sales1@company.com,sales2@company.com,manager@company.com"
}
```

### Fireflies Webhook Setup
1. In Fireflies.ai: Settings → Integrations → Webhooks
2. Create subscription for "Meeting Complete" events
3. Target URL: `http://your-n8n-domain:5678/webhook/fireflies-meeting-webhook`

## Data Handling

### Ephemeral Processing
- **No Data Storage**: All meeting data processed in memory only
- **No Persistence**: Data discarded immediately after processing
- **Privacy**: Sensitive meeting content never stored

### Error Handling
- **API Failures**: Continues processing other meetings
- **AI Analysis Errors**: Falls back to basic summary
- **Email Failures**: Logs errors without stopping workflow

## Technical Details

### Node Types Used
- **Webhook**: Receives external notifications
- **HTTP Request**: Communicates with Fireflies GraphQL API
- **Code**: Data transformation and formatting
- **Split In Batches**: Loop processing for multiple meetings
- **Google Gemini**: AI analysis of transcripts
- **Email Send**: Delivers formatted reports
- **Respond to Webhook**: Confirms successful processing

### API Integration
- **Fireflies GraphQL API**: Used for fetching meetings and transcripts
- **Authentication**: Bearer token in Authorization header
- **Content-Type**: application/json for all requests

### Performance Considerations
- **Individual Processing**: Each meeting analyzed separately for accuracy
- **Sequential Execution**: Meetings processed one at a time
- **Memory Efficient**: No persistent storage requirements

## Usage Examples

### Typical Meeting Analysis
```
Input: 30-minute sales demo transcript
Output: Email with:
- Deal Status: "qualification"
- Probability: 75%
- 3 buying signals identified
- 1 objection noted
- 2 action items
- High urgency recommendation
```

### Batch Processing
- Multiple meetings completed simultaneously
- Each processed individually
- Separate emails sent for each meeting
- No conflicts or data mixing

## Monitoring and Maintenance

### Health Checks
- **Webhook Logs**: Track incoming notifications
- **Execution History**: Monitor processing success/failure
- **Email Delivery**: Verify successful sends

### Troubleshooting
- **Webhook Issues**: Verify Fireflies webhook URL and settings
- **API Errors**: Check Fireflies API key validity
- **Email Problems**: Verify SMTP configuration
- **AI Failures**: Check Gemini API connectivity

## Security

- **API Keys**: Stored securely in n8n credentials
- **HTTPS**: Recommended for webhook endpoints
- **Access Control**: Limit n8n access to authorized users
- **Data Privacy**: No meeting content stored permanently

## Customization Options

### AI Analysis
- Modify prompts in Gemini node for different analysis focus
- Adjust probability thresholds and scoring logic
- Add industry-specific analysis criteria

### Email Templates
- Customize HTML styling and colors
- Add company branding and logos
- Modify sections and content structure

### Meeting Filtering
- Update GraphQL queries to filter meetings
- Add logic for specific participant requirements
- Implement duration or title-based filtering

## Dependencies

- **n8n**: Version 1.122.4 or compatible
- **Fireflies.ai**: Active account with API access
- **Google Gemini**: API access configured
- **SMTP Service**: Email delivery capability

## Related Files

- **Workflow JSON**: `fireflies-ai-sales-meeting-intelligence.json`
- **Setup Guide**: `FIREFLIES_SETUP.md`
- **Environment Config**: `.env` (for credentials)