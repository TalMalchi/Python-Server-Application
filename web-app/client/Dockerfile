# Step 1: Use the official Python Alpine base image
FROM python:3.11-alpine

# Step 4: Set the working directory
WORKDIR /app

# Step 5: Copy the requirements.txt for the client-side application
COPY requirements.txt .

# Step 6: Install Python dependencies for the client
RUN pip install --no-cache-dir -r requirements.txt

# Step 7: Copy the client-side application code
COPY . .

# Step 9: Specify the command to run the Python client
CMD ["python", "client.py"]
