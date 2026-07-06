FROM alpine:latest
RUN apk add --no-cache ffmpeg bash
COPY restream.sh /restream.sh
RUN chmod +x /restream.sh
CMD ["/restream.sh"]
