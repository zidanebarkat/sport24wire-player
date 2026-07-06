#!/bin/bash
# Restream HLS to Facebook (and optionally TikTok)
# Usage: ./restream.sh <hls_url>
# Get RTMP keys from: facebook.com/live/producer and tiktok.com/live

HLS_URL="${1:-https://2.simokora.com/my-hls/h9asfma10d5.m3u8}"
FACEBOOK_KEY="${FB_KEY:-}"
TIKTOK_KEY="${TT_KEY:-}"

if [ -z "$FACEBOOK_KEY" ]; then
    echo "❌ Set FB_KEY env var"
    exit 1
fi

FB_URL="rtmps://live-api.facebook.com:443/rtmp/$FACEBOOK_KEY"

echo "🎬 Restreaming: $HLS_URL"
echo "   → Facebook: rtmps://live-api.facebook.com:443/rtmp/***"

while true; do
    if [ -n "$TIKTOK_KEY" ]; then
        TT_URL="rtmps://push-pub-rtmp-tt.livepush.com/live/$TIKTOK_KEY"
        echo "   → TikTok: live"
        ffmpeg -re -timeout 30000000 -i "$HLS_URL" \
            -c:v libx264 -preset veryfast -b:v 2500k -maxrate 2500k -bufsize 5000k \
            -c:a aac -b:a 128k -ar 44100 \
            -f flv "$FB_URL" \
            -c:v copy -c:a copy \
            -f flv "$TT_URL" \
            -loglevel warning -stats
    else
        ffmpeg -re -timeout 30000000 -i "$HLS_URL" \
            -c:v libx264 -preset veryfast -b:v 2500k -maxrate 2500k -bufsize 5000k \
            -c:a aac -b:a 128k -ar 44100 \
            -f flv "$FB_URL" \
            -loglevel warning -stats
    fi

    echo "⚠️  Stream ended, retrying in 10s..."
    sleep 10
done
