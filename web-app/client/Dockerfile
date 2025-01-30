# Use the official Python Alpine base image
FROM python:3.11-alpine

#  Set the working directory
WORKDIR /app

#  Copy the requirements.txt for the client-side application in tmp directory
COPY requirements.txt /tmp/

# Install Python dependencies for the client
RUN pip install --no-cache-dir -r /tmp/requirements.txt


# Copy the client-side application code
COPY . .

# Specify the command to run the Python client
CMD ["python", "client.py"]
