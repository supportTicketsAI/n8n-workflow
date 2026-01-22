# Use the official n8n image as base
FROM n8nio/n8n:latest

# Install postgresql-client for pg_isready command
USER root
RUN apk add --no-cache postgresql-client

# Switch back to node user
USER node

# Set the working directory
WORKDIR /home/node

# Copy startup script
COPY start.sh /home/node/start.sh
USER root
RUN chmod +x /home/node/start.sh
USER node

# Copy any custom workflows if needed
# COPY flow.json /home/node/.n8n/

# Expose the port that Railway will use
EXPOSE 5678

# Start n8n using our custom script
CMD ["/home/node/start.sh"]