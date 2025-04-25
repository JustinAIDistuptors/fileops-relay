FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the relay implementation
COPY relay.py .
RUN mv relay.py main.py

# Set environment variables
ENV PORT=8080
ENV LOG_LEVEL=debug
ENV PYTHONUNBUFFERED=1
ENV SERVICE_NAME=fileops
ENV FILEOPS_PATH=/sss
ENV UPSTREAM_URL=https://fileops-mcp.fly.dev

# Expose the port
EXPOSE 8080

# Use uvicorn to run the app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
