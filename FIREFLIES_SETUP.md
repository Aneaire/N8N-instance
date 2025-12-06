# Fireflies AI Sales Meeting Intelligence

This system automatically analyzes sales meeting transcripts from Fireflies.ai using AI and sends intelligent email summaries to your sales team.

## 🚀 Features

- **Real-time Meeting Analysis**: Automatically processes meetings when they complete
- **AI-Powered Sales Intelligence**: Extracts deal status, buying signals, objections, and action items
- **Automated Email Alerts**: Sends formatted intelligence reports to sales team
- **Batch Processing**: Handles multiple meetings simultaneously
- **Ephemeral Processing**: No data storage - everything processed in memory
- **Manual Email Configuration**: Easy to update recipient list without code changes

## 📊 AI Analysis Capabilities

### Sales Intelligence Extracted
- **Deal Status**: Current stage (prospecting, qualification, proposal, etc.)
- **Close Probability**: 0-100% likelihood of closing
- **Buying Signals**: Interest indicators and positive buying behavior
- **Objections**: Concerns, blockers, and competitor mentions
- **Action Items**: Commitments and follow-up tasks
- **Sentiment Analysis**: Overall meeting tone and engagement
- **Key Topics**: Main discussion points and product interests
- **Decision Makers**: Key stakeholders and their roles
- **Recommendations**: Specific sales actions and urgency levels

## 🛠️ Setup Instructions

### 1. Configure Environment Variables

Update your `.env` file with Fireflies API credentials:

```bash
# Add to your .env file
FIREFLIES_API_KEY=your_fireflies_api_key_here
```

### 2. Start the System

```bash
docker-compose up -d
```

### 3. Access n8n

Open your browser and navigate to: `http://localhost:5678`

Login with the credentials you set in the environment file.

### 4. Import Workflow

1. In n8n, go to "Workflows" → "Import from file"
2. Import the workflow file: `fireflies-ai-sales-meeting-intelligence.json`

### 5. Configure Credentials

In n8n, set up the following credentials:

#### Fireflies API
- Go to Settings → Credentials
- Add "Fireflies API" credential
- Use your Fireflies API key
- Name it "fireflies-api-key" (matches the workflow)

#### SMTP Email
- Add "SMTP" credential for sending sales alerts
- Configure with your email provider settings
- Name it "smtp-credentials" (matches the workflow)

### 6. Configure Sales Team Emails

In the workflow, find the "Sales Team Email Configuration" node and update the email addresses:

```json
{
  "salesTeamEmails": "sales1@company.com,sales2@company.com,manager@company.com"
}
```

Replace with your actual sales team email addresses (comma-separated).

### 7. Set Up Fireflies Webhook

1. In your Fireflies.ai account, go to Settings → Integrations → Webhooks
2. Create a new webhook subscription
3. Subscribe to "Meeting Complete" events
4. Set the target URL to: `http://your-n8n-domain:5678/webhook/fireflies-meeting-webhook`
5. Replace `your-n8n-domain` with your actual n8n domain
6. Save and activate the webhook

## 🎯 Workflow Flow

### Real-time Processing (Webhook Trigger)
- **Trigger**: Webhook from Fireflies when meeting completes
- **Process**:
  1. Receives meeting notification from Fireflies
  2. Fetches recent meetings (last 24 hours) to catch any missed
  3. Loops through each meeting individually
  4. Retrieves full transcript for each meeting
  5. Runs AI analysis on transcript
  6. Formats professional email with insights
  7. Sends email to sales team
  8. Returns success response

### Data Flow
1. **Webhook Trigger** → Receives meeting completion notification
2. **Get Recent Meetings** → Fetches meetings from last 24 hours via GraphQL API
3. **Extract Meetings Array** → Parses GraphQL response into usable array
4. **Loop Over Meetings** → Processes each meeting individually
5. **Get Meeting Transcript** → Fetches full transcript and metadata
6. **Format Transcript Data** → Converts to format suitable for AI analysis
7. **Gemini AI Sales Analysis** → Analyzes transcript for sales intelligence
8. **Prepare Email Data** → Formats analysis into HTML email
9. **Send Sales Intelligence Email** → Delivers to sales team
10. **Webhook Response** → Confirms successful processing

## 📧 Email Output Format

### Subject Line
`🚀 Sales Meeting: [Meeting Title] - [Deal Status] ([Probability]% probability)`

### Email Content Sections
- **Meeting Overview**: Title, participants, duration, date
- **Deal Status & Probability**: Current stage with color coding
- **Buying Signals**: ✅ Green section with positive indicators
- **Objections & Concerns**: ⚠️ Red section with blockers
- **Action Items**: 📋 Orange section with commitments
- **AI Recommendations**: 🎯 Purple section with next steps and urgency
- **Key Topics**: 💬 Teal section with discussion points

## 🎨 Email Styling

- **Professional Design**: Clean, modern HTML layout
- **Color Coding**: Status-based colors (green=high probability, red=concerns)
- **Responsive**: Works on desktop and mobile
- **Branded**: Consistent styling with your existing communications

## 🔧 Customization Options

### Modifying AI Analysis
Edit the "Gemini AI Sales Analysis" node to:
- Adjust analysis focus (more/less emphasis on certain aspects)
- Change probability thresholds
- Add industry-specific analysis criteria

### Email Template Customization
Modify the "Prepare Email Data" code node to:
- Change color scheme
- Add company branding/logo
- Customize sections or add new ones
- Modify subject line format

### Meeting Filtering
Update the "Get Recent Meetings" query to:
- Filter by meeting title patterns
- Limit to specific participants
- Filter by meeting duration
- Focus on certain time periods

### Email Recipients
The "Sales Team Email Configuration" node allows easy updates:
- Add/remove team members
- Create different recipient groups
- Dynamic routing based on meeting content

## 📈 Performance & Scaling

### Processing Capacity
- **Individual Analysis**: Each meeting processed separately for accuracy
- **Batch Handling**: Multiple meetings processed in sequence
- **Memory Efficient**: No persistent storage, data discarded after processing

### Error Handling
- **API Failures**: Continues processing other meetings
- **AI Analysis Errors**: Falls back to basic summary
- **Email Failures**: Logs errors without stopping workflow

### Monitoring
- **Webhook Logs**: Track incoming notifications
- **Execution History**: Monitor processing success/failure
- **Email Delivery**: Verify successful sends

## 🔒 Security Considerations

- **API Keys**: Store securely in n8n credentials
- **HTTPS**: Use HTTPS for webhook endpoints
- **Access Control**: Limit n8n access to authorized users
- **Data Privacy**: No meeting data stored permanently
- **Email Security**: Use secure SMTP settings

## 🐛 Troubleshooting

### Common Issues
1. **Webhook not triggering**: Verify Fireflies webhook URL and settings
2. **API authentication errors**: Check Fireflies API key in n8n credentials
3. **Email not sending**: Verify SMTP configuration and credentials
4. **AI analysis failures**: Check Gemini API connectivity and quotas
5. **Empty transcripts**: Ensure meetings have completed transcription

### Debug Steps
1. **Test webhook**: Use tools like webhook.site to test incoming data
2. **Check API responses**: Add debug nodes to inspect API responses
3. **Verify credentials**: Test API connections manually
4. **Monitor executions**: Review n8n execution logs for errors

## 📞 Support

For issues with:
- **Fireflies API**: Check Fireflies developer documentation
- **n8n workflows**: Review n8n community forums and documentation
- **Gemini AI**: Check Google AI documentation
- **Email delivery**: Verify SMTP provider settings

## 🎯 Best Practices

### Meeting Preparation
- **Title Conventions**: Use descriptive meeting titles (e.g., "Demo - ABC Corp")
- **Participant Info**: Ensure participant emails are up to date
- **Recording Quality**: High-quality audio improves transcription accuracy

### Sales Team Usage
- **Action Items**: Use AI recommendations as starting points, not final decisions
- **Follow-up Timing**: Respect urgency levels from AI analysis
- **Feedback Loop**: Provide feedback on analysis accuracy for improvements

### Maintenance
- **Regular Updates**: Keep email lists current
- **Monitor Performance**: Review execution logs regularly
- **Update Credentials**: Rotate API keys periodically