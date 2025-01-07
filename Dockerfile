FROM golang:1.22-alpine AS build-env
RUN apk add --update --no-cache ca-certificates git
RUN mkdir /app

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/gact

FROM scratch
COPY --from=build-env /go/bin/gact /go/bin/gact

EXPOSE 8080

ENV GIN_MODE=release

CMD ["/go/bin/gact"]