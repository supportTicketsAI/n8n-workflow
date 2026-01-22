# Use the official n8n image as base
FROM n8nio/n8n:latest

# Copy any custom workflows if needed
# COPY flow.json /home/node/.n8n/

# Expose the port that Railway will use
EXPOSE 5678

# Use the default command from the base image (no need to override)