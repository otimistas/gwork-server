FROM golang:1.21 as build-server

WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /go/bin/app .

# hadolint ignore=DL3006
FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=build-server /go/bin/app /server/

ENTRYPOINT [ "/server/app" ]
