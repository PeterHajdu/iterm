all: terminal

terminal: terminal.o

clean:
	rm -f *.o *.ibc

pkg:
	idris --build iterm.ipkg
	idris --install iterm.ipkg

.PHONY: terminal clean
