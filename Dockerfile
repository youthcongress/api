# Stage 1: Build
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20 AS builder

# Set working directory
WORKDIR /app

# Copy and run setup script to update Alpine repositories & install Go
COPY .devcontainer/setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire app
COPY . .

# Build the Go application
RUN go build -o main main.go  # Ensure main.go exists

# Stage 2: Run
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set working directory
WORKDIR /app

# Copy the built binary and necessary files
COPY --from=builder /app/main .
COPY --from=builder /app/public ./public

# Ensure required dependencies are installed
RUN apk add --no-cache ca-certificates

# Make sure the binary has execute permission
RUN chmod +x /app/main

# Expose the API port
EXPOSE 8010

# Start the Go API server
CMD ["/app/main"]
