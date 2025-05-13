FROM alpine:latest

RUN apk update && apk add crystal ncurses-static make shards
