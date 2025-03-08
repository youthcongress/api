# Stage 1: Build
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20 AS builder

# Set working directory
WORKDIR /app

# Copy Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire app
COPY . .

# Build the Go application
RUN go build -o main main.go

# Stage 2: Run
FROM mcr.microsoft.com/devcontainers/base:alpine-3.20

# Set working directory
WORKDIR /app

# Copy the built binary and necessary files
COPY --from=builder /app/main .

# Expose the API port
EXPOSE 8010

# Start the Go API server
CMD ["/app/main"]
