#!/bin/bash
HLS_URL="${1:-https://2.simokora.com/my-hls/h9asfma10d5.m3u8}"
FACEBOOK_KEY="${FB_KEY:-}"
TIKTOK_KEY="${TT_KEY:-}"

if [ -z "$FACEBOOK_KEY" ]; then
    echo "❌ Set FB_KEY env var"
    exit 1
fi

FB_SERVER="rtmps://live-api-s.facebook.com:443/rtmp"
FB_URL="$FB_SERVER/$FACEBOOK_KEY"

echo "🎬 Restreaming: $HLS_URL"
echo "   → Facebook: $FB_SERVER/***"

while true; do
    if [ -n "$TIKTOK_KEY" ]; then
        TT_URL="rtmps://push-pub-rtmp-tt.livepush.com/live/$TIKTOK_KEY"
        echo "   → TikTok: live"
        ffmpeg -re -timeout 30000000 -i "$HLS_URL" \
            -c:v libx264 -preset ultrafast -b:v 1500k -maxrate 1500k -bufsize 3000k \
            -c:a aac -b:a 96k -ar 44100 \
            -f flv "$FB_URL" \
            -c:v copy -c:a copy \
            -f flv "$TT_URL" \
            -loglevel warning -stats
    else
        ffmpeg -re -timeout 30000000 -i "$HLS_URL" \
            -c:v libx264 -preset ultrafast -b:v 1500k -maxrate 1500k -bufsize 3000k \
            -c:a aac -b:a 96k -ar 44100 \
            -f flv "$FB_URL" \
            -loglevel warning -stats
    fi

    echo "⚠️  Stream ended, retrying in 10s..."
    sleep 10
done
