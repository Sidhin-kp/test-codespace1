# Step 1: Build the Go binary
FROM golang:1.20-alpine as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules manifests
COPY go.mod  ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod tidy

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o main .

# Step 2: Create the final image
FROM alpine:latest

# Install ca-certificates to allow SSL communication
RUN apk --no-cache add ca-certificates

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Go binary and HTML file from the builder image
COPY --from=builder /app/main .
COPY --from=builder /app/index.html .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
