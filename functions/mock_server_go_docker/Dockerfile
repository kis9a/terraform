### build stage ###
FROM golang:1.14 as builder
COPY server.go .
RUN go build \
  -ldflags "-linkmode external -extldflags -static" \
  -a server.go

### run stage ###
FROM scratch
COPY --from=builder /go/server ./server
CMD ["./server"]
