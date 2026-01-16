# Use Python slim base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies for Pygame
RUN apt-get update && \
    apt-get install -y \
    libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev \
    libsmpeg-dev libportmidi-dev libavformat-dev libswscale-dev \
    libjpeg-dev libfreetype6-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir pygame numpy pillow matplotlib python-dotenv

# Set dummy display (headless)
ENV SDL_VIDEODRIVER=dummy

# Run the simulation
CMD ["python", "smart-simulation.py"]
