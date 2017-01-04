# How to use secShark.pl
# Run this on a Linux machine with IPsec tunnels ESTABLISHED (using strongswan).
#
mkdir -p ~/.wireshark

# Make a backup so we don't clobber what was already there.
#
cp ~/.wireshark/esp_sa ~/.wireshark/esp_sa.backup

# Get the 'ip xfrm state' output and save it in xfrm.out
#
ip xfrm state list > xfrm.out

# Run it through secShark.pl and put the output to esp_sa.
#
perl secShark.pl xfrm.out > ~/.wireshark/esp_sa

# Now start wireshark and ensure that ESP decoding is enabled.
# The xfrm keys will already be populated in the wireshark config via
# the esp_sa file. If you capture ESP frames, they will now be decoded.
