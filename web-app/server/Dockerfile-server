# Step 1: Use the official Python Alpine base image
FROM python:3.11-alpine

# Step 4: Create a non-root user to run the app
RUN adduser -D -g '' appuser

# Step 5: Set the working directory
WORKDIR /app

# Step 6: Change ownership of the working directory to the non-root user
RUN chown -R appuser /app

# Step 7: Switch to the non-root user
USER appuser

# Step 8: Copy requirements.txt first (to leverage build caching)
COPY --chown=appuser requirements.txt .

# Step 9: Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Step 10: Copy the rest of the application code
COPY --chown=appuser . .

# Step 11: Expose the Flask default port
EXPOSE 5000

# Step 12: Specify the command to run the Flask application
CMD ["python", "server.py"]
