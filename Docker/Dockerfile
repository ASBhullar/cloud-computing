# Use Ubuntu 20.04 LTS as base image
FROM ubuntu:20.04

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Update and install sysbench
RUN apt-get update && \
    apt-get install -y sysbench && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Specify the default command for the container
CMD ["bash"]
