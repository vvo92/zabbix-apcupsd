# Use the official Zabbix agent image as the base image
FROM zabbix/zabbix-agent:latest

# Switch to root user to perform permission change
USER root

# Install Python3
RUN apk update && apk add --no-cache python3

# Create the necessary directories
RUN mkdir -p /etc/zabbix/zabbix_agentd.d /etc/zabbix/scripts

# Copy apc.conf to /etc/zabbix/zabbix_agentd.d
COPY apc.conf /etc/zabbix/zabbix_agentd.d/apc.conf

# Copy apc.py to /etc/zabbix/scripts
COPY apc.py /etc/zabbix/scripts/apc.py

# Ensure the script has the correct permissions
RUN chmod +x /etc/zabbix/scripts/apc.py

# Switch back to the zabbix user
USER zabbix

# Set environment variables for the script
ENV HOST=127.0.0.1
ENV PORT=3551

# Expose any necessary ports (this is optional and depends on your setup)
EXPOSE 10050

# Run the Zabbix agent
CMD ["zabbix_agentd", "-f"]
