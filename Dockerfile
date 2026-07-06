FROM alpine:latest

RUN apk add --no-cache ffmpeg bash curl socat

COPY restream.sh /restream.sh
RUN chmod +x /restream.sh

# Health check endpoint
EXPOSE 8080

CMD ["/bin/sh", "-c", "nohup /restream.sh > /tmp/restream.log 2>&1 & echo -e 'HTTP/1.1 200 OK\n\nRestream running' | socat TCP-LISTEN:8080,reuseaddr,fork STDIN"]
