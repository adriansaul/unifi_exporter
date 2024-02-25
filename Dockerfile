FROM golang:1.19.0-alpine AS build
RUN mkdir /unifi_exporter
WORKDIR /unifi_exporter
COPY  . .
RUN go env -w GOPROXY=direct
RUN CGO_ENABLED=0 GOOS=linux go build ./cmd/unifi_exporter

FROM alpine:3
COPY --from=build /unifi_exporter/unifi_exporter /bin
EXPOSE 9130
USER nobody
ENTRYPOINT ["/bin/unifi_exporter"]
