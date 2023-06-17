SOURCES = $(wildcard *.d)
OUTPUTS = $(patsubst %.d,%.iso,$(SOURCES))

all: $(OUTPUTS)

clean:
	rm -f $(OUTPUTS)

%.iso: %.d/meta-data %.d/user-data
	@rm -f $@
	genisoimage -o $@ -q -r -J -input-charset utf-8 -V cidata $(dir $<)

