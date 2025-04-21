FROM deepaksy/portfolio-backend-app:latest

# Set working directory to /app
WORKDIR /app

# Copy the .env file from /data (which maps to /config in HA)
COPY /data/.env /app/.env

# Copy the run.sh script into the container
COPY run.sh /run.sh

# Make the run.sh script executable
RUN chmod a+x /run.sh

# Set the default command to run the script
CMD [ "/run.sh" ]

