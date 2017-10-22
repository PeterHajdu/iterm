all: terminal

terminal: terminal.o

clean:
	rm -f *.o *.ibc

.PHONY: terminal
