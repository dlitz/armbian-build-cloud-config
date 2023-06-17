cidata.iso: cidata/meta-data cidata/user-data
	-rm -f cidata.iso
	genisoimage -o $@ -q -r -J -v -input-charset utf-8 -V cidata cidata
