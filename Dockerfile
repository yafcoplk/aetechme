FROM python:3.9-slim

# Run as root (required for apt)
USER root

# Fix /tmp permissions (CRITICAL for SageMaker)
RUN chmod 1777 /tmp

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git \
        wget \
        libicu-dev \
        libncurses6 \
        libncursesw6 \
        libtinfo6 && \
    rm -rf /var/lib/apt/lists/*

# Copy your training code
COPY trainer /app/trainer

# Ensure Python logs show immediately
ENV PYTHONUNBUFFERED=1

# SageMaker training entrypoint
ENTRYPOINT ["python", "-m", "trainer.task"]
