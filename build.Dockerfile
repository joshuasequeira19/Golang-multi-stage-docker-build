# Build stage
FROM golang:1.17 AS build

WORKDIR /app
COPY calculator.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o calculator .

# Final stage
FROM scratch

COPY --from=build /app/calculator /calculator

ENTRYPOINT ["/calculator"]
CMD ["6", "+", "9"]  # Default calculation: 6 + 9

EXPOSE 8080