# Sport24Wire Live Player

## 🌐 Live Player
- **GitHub Pages:** https://zidanebarkat.github.io/sport24wire-player/
- **Render:** Deploy `render.yaml` to https://render.com

## 📡 Restream to Facebook + TikTok (24/7)

### Option 1: Oracle Cloud Free Tier (recommended)
Best for 24/7 restreaming — always-free ARM VM.

```bash
# SSH into your Oracle Cloud VM
ssh ubuntu@<your-vm-ip>

# Install FFmpeg
sudo apt update && sudo apt install ffmpeg -y

# Download restream script
wget https://raw.githubusercontent.com/zidanebarkat/sport24wire-player/master/restream.sh
chmod +x restream.sh

# Run (get RTMP keys from Facebook/TikTok)
FB_KEY=your_fb_key TT_KEY=your_tt_key ./restream.sh
```

### Option 2: Render Background Worker
```bash
# Deploy Dockerfile as a Background Worker on Render
# Set env vars: FB_KEY, TT_KEY, HLS_URL
# Note: free tier may sleep — use $7/month plan for 24/7
```

### Option 3: Any VPS (DigitalOcean, Linode, etc.)
Same as Oracle Cloud — just SSH in and run the script.

## 🔑 Getting Stream Keys

**Facebook:** https://facebook.com/live/producer → Create live stream → Copy stream key
**TikTok:** Open TikTok Live → Settings → Stream key

## 📺 OBS Source
```
https://cu.ebda3io.store/nppsf3.m3u8
```
