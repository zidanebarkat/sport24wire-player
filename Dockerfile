FROM alpine:latest

RUN apk add --no-cache ffmpeg bash curl font-noto fontconfig

COPY restream.sh /restream.sh
RUN chmod +x /restream.sh

# Health check endpoint
EXPOSE 8080

CMD ["/bin/sh", "-c", "nohup /restream.sh > /tmp/restream.log 2>&1 & while true; do echo -e 'HTTP/1.1 200 OK\n\nRestream running' | nc -l -p 8080 -q 1 2>/dev/null; done"]
