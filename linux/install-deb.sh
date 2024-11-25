url=$1

TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" $url &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"
