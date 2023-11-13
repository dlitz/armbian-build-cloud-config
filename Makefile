subdirs :=
subdirs += debian12-bookworm

SOURCES = $(wildcard $(patsubst %,%/*.yml,$(subdirs)))
OUTPUTS = $(patsubst %.yml,output/nocloud/%.iso,$(SOURCES))

all: $(OUTPUTS)

clean:
	rm -f $(OUTPUTS)

tmp/nocloud/%/user-data: %.yml tmp/nocloud
	mkdir -p $(dir $@)
	install -m0644 $< $@

tmp/nocloud/%/meta-data:
	mkdir -p $(dir $@)
	printf '%s\n%s\n' "instance-id: $(notdir $(dir $@))" "local-hostname: $(notdir $(dir $@))" > $@

output/nocloud/%.iso: tmp/nocloud/%/user-data tmp/nocloud/%/meta-data
	mkdir -p $(dir $@)
	genisoimage -o $@ -q -r -J -input-charset utf-8 -V cidata $(dir $<)

.PHONY: all clean output/nocloud tmp/nocloud

#%.iso: %.d/meta-data %.d/user-data
#	@rm -f $@
#	genisoimage -o $@ -q -r -J -input-charset utf-8 -V cidata $(dir $<)

