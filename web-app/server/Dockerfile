#  Use the official Python Alpine base image
FROM python:3.11-alpine

# Create a non-root user to run the app
RUN adduser -D -g '' appuser

# Set the working directory
WORKDIR /app

# Change ownership of the working directory to the non-root user
RUN chown -R appuser /app

# Install curl for health checks
RUN apk add curl

# Switch to the non-root user
USER appuser

# Copy requirements.txt first (to leverage build caching)
COPY --chown=appuser requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY --chown=appuser . .

# Expose the Flask default port
EXPOSE 5000

# Specify the command to run the Flask application
CMD ["python", "server.py"]
