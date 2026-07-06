export FLYCTL_INSTALL="/home/dev/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
flyctl ssh console -a sport24wire-restream -C "cat /tmp/restream.log"
