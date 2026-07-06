#!/bin/bash
HLS_URL="${1:-https://2.simokora.com/my-hls/h9asfma10d5.m3u8}"
FACEBOOK_KEY="${FB_KEY:-}"

if [ -z "$FACEBOOK_KEY" ]; then
    echo "❌ Set FB_KEY env var"
    exit 1
fi

FB_URL="rtmps://live-api-s.facebook.com:443/rtmp/$FACEBOOK_KEY"
echo "🎬 Restreaming: $HLS_URL"
echo "   → Facebook"

while true; do
    ffmpeg -re -timeout 30000000 -i "$HLS_URL" \
        -af "volume=1.08" \
        -c:v copy \
        -c:a aac -b:a 96k -ar 44100 \
        -metadata title="S24W Live" -metadata encoder="S24W" \
        -f flv "$FB_URL" \
        -loglevel warning -stats

    echo "⚠️  Disconnected, retrying in 10s..."
    sleep 10
done
