#!/bin/bash
# Restream HLS to Facebook + TikTok simultaneously
# Usage: ./restream.sh <hls_url>
# Get RTMP keys from: facebook.com/live/producer and tiktok.com/live

HLS_URL="${1:-https://cu.ebda3io.store/nppsf3.m3u8}"
FACEBOOK_KEY="${FB_KEY:-}"
TIKTOK_KEY="${TT_KEY:-}"

if [ -z "$FACEBOOK_KEY" ] || [ -z "$TIKTOK_KEY" ]; then
    echo "❌ Set FB_KEY and TT_KEY env vars"
    echo "   FB_KEY=your-facebook-rtmp-key ./restream.sh"
    echo ""
    echo "Facebook RTMP: rtmps://live-api-s.facebook.com:443/rtmp/{key}"
    echo "TikTok RTMP:   rtmps://push-pub-rtmp-tt.livepush.com/live/{key}"
    exit 1
fi

FB_URL="rtmps://live-api-s.facebook.com:443/rtmp/$FACEBOOK_KEY"
TT_URL="rtmps://push-pub-rtmp-tt.livepush.com/live/$TIKTOK_KEY"

echo "🎬 Restreaming: $HLS_URL"
echo "   → Facebook: rtmps://live-api-s.facebook.com:443/rtmp/***"
echo "   → TikTok:   rtmps://push-pub-rtmp-tt.livepush.com/live/***"

while true; do
    ffmpeg -re -i "$HLS_URL" \
        -c:v libx264 -preset veryfast -b:v 2500k -maxrate 2500k -bufsize 5000k \
        -c:a aac -b:a 128k -ar 44100 \
        -f flv "$FB_URL" \
        -c:v copy -c:a copy \
        -f flv "$TT_URL" \
        -loglevel error
    
    echo "⚠️  Stream ended, retrying in 10s..."
    sleep 10
done
