.PHONY: all ui sync clean

OFFLINEIMAP = /usr/bin/offlineimap.py

all:

ui:
	mkdir -p mutt_cache mutt_tmp
	mutt-patched -F muttrc

sync:
	$(OFFLINEIMAP) -o -c offlineimaprc -l offlineimap.log

clean:
	rm -f -- offlineimap.log *~
	rm -rf mutt_cache/* mutt_tmp/*
