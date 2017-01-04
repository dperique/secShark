# secShark
Utility to create .wireshark/esp_sa file to decode IPsec/ESP frames.

This utility only makes sense when used in conjunction with wireshark with gcrypt enabled.

Take the output of 'ip xfrm state list' and put it into a file called yourfile.log

Run 'perl secShark.pl yourfile.log > ~/.wireshark/esp_sa'.
Start up wireshark, ensure that you turn on ESP decoding.
You will now see ESP frames decoded using the correct keys.
You must repeat this after every IPsec rekey because the keys
are refreshed and the current keys will be invalid.

The output of 'ip xfrm state list' will be non-empty when an IPsec
tunnel is already up.  For example:

```
$ ip xfrm state list

src 100.90.1.1 dst 10.66.22.55
	proto esp spi 0xcea01312 reqid 1 mode tunnel
	replay-window 0 flag 20
	auth hmac(sha256) 0x74a1a8a69a939239236ff4f55c0a3fee43df7bf3b534fe6cab56ba5e69ca04d1
	enc cbc(aes) 0xe76ce6dd8e810a4680899690606e0928cb0c3e002416c2ffe0ba897d24250f80
	encap type espinudp sport 4500 dport 4500 addr 0.0.0.0
src 10.66.22.55 dst 100.90.1.1
	proto esp spi 0xc01f8aa9 reqid 1 mode tunnel
	replay-window 0 flag 20
	auth hmac(sha256) 0x1df865b65ba4919ff787659b63e21a2261f2c35fe0eadc9e8b028b8c347fb166
	enc cbc(aes) 0x13edc144aacbd0826d68eb3e02bc880e0dd161e317dc7291e47cc02adf2ba932
	encap type espinudp sport 4500 dport 4500 addr 0.0.0.0
```
