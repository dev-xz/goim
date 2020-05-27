FROM golang:1.12-alpine AS builder

COPY . /app
WORKDIR /app
RUN go build -mod=vendor -o comet cmd/comet/main.go
RUN go build -mod=vendor -o logic cmd/logic/main.go
RUN go build -mod=vendor -o job cmd/job/main.go

FROM alpine:3.10
LABEL maintainer="dev-xz@outlook.com"
LABEL name="devxz/goim"

ENV PATH .:$PATH
ENV APP_NAME goim

WORKDIR /app
COPY --from=builder /app/comet /app/logic /app/job /app/
COPY configs/* cmd/comet/*.toml cmd/job/*.toml cmd/logic/*.toml /app/

EXPOSE 8000
CMD ["sh"]
