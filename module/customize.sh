
# taken from ksu_toolkit

MODDIR="/data/adb/modules/hot_install"

busybox rm -rf "$MODDIR"
mkdir -p "$MODDIR"
busybox cp -Lrf "$MODPATH"/* "$MODDIR"
(sleep 3 && busybox rm -rf "$MODPATH" && busybox rm "$MODDIR"/update) &

echo "- Self hot install performed!"
echo "- Refresh module page after installation!"
echo "- No need to reboot!"
