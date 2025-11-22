# Use official Python image (latest stable version)
FROM python:3.14-slim

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies needed for building Python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libffi-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, and wheel first
RUN python -m pip install --upgrade pip setuptools wheel

# Copy requirements and install
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . /app

# Apply database migrations (ensure DB is reachable during build or move to entrypoint)
# You might want to run this in entrypoint/start.sh instead of Docker build
# RUN alembic upgrade head

# Entry point
CMD ["bash", "start.sh"]
