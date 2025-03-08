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

# Copy the rest of the application files
COPY . .

# Build the Go application
RUN go build -o main .

# Stage 2: Run
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set working directory
WORKDIR /app

# Copy the built binary and necessary files
COPY --from=builder /app/main .
COPY --from=builder /app/public ./public

# Ensure required dependencies are installed
RUN apk add --no-cache ca-certificates

# Expose the API port
EXPOSE 8010

# Start the API server
CMD ["./main"]
