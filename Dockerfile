FROM python:3.14-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies for Pillow and other packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libffi-dev \
    libjpeg-dev \
    zlib1g-dev \
    libtiff5-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel
RUN python -m pip install --upgrade pip setuptools wheel

# Install Python dependencies
COPY requirements.txt .
RUN python -m pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . /app

# Entry point
CMD ["bash", "start.sh"]
