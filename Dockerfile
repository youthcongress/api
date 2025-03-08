# Use the specified base image
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set the working directory inside the container
WORKDIR /workspaces/api

# Copy the setup script into the container
COPY .devcontainer/setup.sh /workspaces/api/.devcontainer/setup.sh

# Ensure the script has execution permissions
RUN chmod +x /workspaces/api/.devcontainer/setup.sh

# Execute the setup script
RUN /bin/sh /workspaces/api/.devcontainer/setup.sh

# Set the default user as root
USER root

# Expose any necessary ports (if applicable)
EXPOSE 8010  

# Define the default command (modify if needed)
CMD ["sh"]
