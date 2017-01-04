# Author: Dennis Periquet, June 8, 2015.
#
# Take the output of 'ip xfrm state list' and put it into a file.
# Run perl secShark.pl yourfile.log > ~/.wireshark/esp_sa.
# Start up wireshark, ensure that you turn on ESP decoding.
# You must repeat this on every IPsec rekey
# because the keys are refreshed and the current keys will
# be invalid.
#
# Algorithm: the 'ip xfrm state list' output is in a series of 6 line
# chunks.  Each line contains information we need to generate the
# ~/.wireshark/esp_sa file.  We go through each line and extract that
# info and print it out.  We then start on the next 6 lines until done.
# Wireshark will use the esp_sa file to populate the ESP SA entries
# automatically so that ESP packets are decoded for you.
#
my $i = 1;
my $hmac;
my $cbc;
while (<>) {
    chomp($_);
    my @tt = split(/ /, $_);
    if ($i == 1) {
	print '"IPv4",', '"', @tt[1], '","', @tt[3], '",';
    }
    if ($i == 2) {
	print '"', @tt[3], '",';
	print '"AES-CBC [RFC3602]",';
    }
    if ($i == 4) {
	$hmac = @tt[2];
    }
    if ($i == 5) {
	$cbc = @tt[2];
    }
    if ($i == 6) {
	print '"', $cbc, '",';
	print '"HMAC-SHA-256-128 [RFC4868]",';
	print '"', $hmac, '"';
	print "\n";
	$i = 0;
    }
    $i++;
}
