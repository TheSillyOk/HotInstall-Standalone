# taken from ksu_toolkit
MODDIR="/data/adb/modules/hot_install"

(sleep 3;
  busybox rm -rf "$MODDIR";
  mkdir -p "$MODDIR";
  busybox cp -Lrf "$MODPATH"/* "$MODDIR";
  busybox rm -rf "$MODPATH";
)&

echo "- Self hot install performed!"
echo "- Refresh module page after installation!"
echo "- No need to reboot!"
