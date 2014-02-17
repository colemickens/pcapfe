all:
	rustc lib.rs

gen:
	../../crabtw/rust-bindgen/bindgen \
		-builtins \
		-l pcap \
		-o pcap.rs \
		/usr/include/pcap/pcap.h \
		-I/usr/lib/clang/3.4/include/

	echo '#[ignore(dead_code)]' | cat - pcap.rs > pcap.rs-temp && mv pcap.rs-temp pcap.rs

	echo ''									        >> pcap.rs
	echo '#[cfg(windows)]'          >> pcap.rs
	echo '#[link(name = "wpcap")]'  >> pcap.rs
	echo 'extern "C" {}'            >> pcap.rs

	echo ''                         >> pcap.rs
	echo '#[cfg(not(windows))]'     >> pcap.rs
	echo '#[link(name = "pcap")]'   >> pcap.rs
	echo 'extern "C" {}'            >> pcap.rs