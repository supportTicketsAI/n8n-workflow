# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set the working directory
WORKDIR /home/node

# Copy any custom workflows if needed
# COPY flow.json /home/node/.n8n/

# Expose the port that Railway will use
EXPOSE 5678

# Start n8n directly
CMD ["n8n", "start"]