FROM golang:1.16.6-buster AS builder

ARG VERSION=dev

WORKDIR /go/src/app
COPY . .
RUN go build -o main -ldflags=-X=main.version=${VERSION} main.go 

FROM debian:buster-slim
COPY --from=builder /go/src/app/main /go/bin/main
ENV PATH="/go/bin:${PATH}"
CMD ["main"]
