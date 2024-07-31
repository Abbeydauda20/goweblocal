# Base stage with Go
FROM golang:1.21 as base

# Set the working directory
WORKDIR /app

# Copy go.mod file
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the Go application
RUN go build -o main .

# Final stage with distroless image
FROM gcr.io/distroless/base

# Set the working directory
WORKDIR /app

# Copy the Go binary from the base stage
COPY --from=base /app/main .

# Copy the static files from the base stage
COPY --from=base /app/static ./static

# Expose port 8080 for the container
EXPOSE 8080

# Command to run the Go application another
CMD ["./main"]

