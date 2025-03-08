# Stage 1: Build
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20 AS builder

# Set working directory
WORKDIR /app

# Copy and run setup script to update Alpine repositories & install Go
COPY .devcontainer/setup.sh /setup.sh
RUN chmod +x /setup.sh && /setup.sh

# Ensure Go is installed (if setup.sh fails)
RUN apk update && apk add --no-cache go=1.24.0-r0

# Copy Go module files and download dependencies
COPY go.mod go.sum ./ 
RUN go mod download

# Copy the entire app
COPY . .

# Ensure the public directory exists
RUN mkdir -p /app/public

# Build the Go application
RUN go build -o main main.go  # Ensure main.go exists

# Stage 2: Run
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set working directory
WORKDIR /app

# Copy the built binary and necessary files
COPY --from=builder /app/main .
COPY --from=builder /app/public ./public || true

# Ensure necessary runtime dependencies are installed
RUN apk add --no-cache ca-certificates

# Expose the API port
EXPOSE 8010

# Run the API server
CMD ["/app/main"]
