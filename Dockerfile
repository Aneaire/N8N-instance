FROM docker.n8n.io/n8nio/n8n

# Set environment variables for Railway
ENV N8N_HOST=${RAILWAY_PUBLIC_DOMAIN}
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV WEBHOOK_URL=https://${RAILWAY_PUBLIC_DOMAIN}/
ENV N8N_SECURE_COOKIE=false

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1