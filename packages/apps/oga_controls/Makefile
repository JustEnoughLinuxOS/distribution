cc = gcc
CFLAGS += -W -Wall

BINARY = oga_controls
LIBRARIES = -levdev -lSDL2
SOURCES = "main.c"

all:
	$(CC) $(CFLAGS) $(SOURCES) -o $(BINARY) $(LIBRARIES)

clean:
	rm -f $(BINARY)
