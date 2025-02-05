VERSION = \"0.1\"

MGINC = deps/mongoose
MGSRC = ${MGINC}/mongoose.c
MGOBJ = mongoose.o
LDFLAGS = -lssl -lcrypto
CFLAGS = -I${MGINC} \
	 -DDEBUG -DVERSION=${VERSION} -DCOMPILER=\"${CC}\" \
	 -DCOMMIT=\"$(shell git rev-parse --short HEAD)\" \
	 -std=gnu99

SRC = affogato.c test.c
OBJ = ${SRC:.c=.o} ${MGOBJ}

all: clean test

test: ${OBJ}
	${CC} ${LDFLAGS} -o test ${OBJ}

${OBJ}: ${SRC} ${MGSRC}
	${CC} ${CFLAGS} -c ${SRC} ${MGSRC}

deps:
	rm -rf deps
	mkdir deps &2>/dev/null
	git clone https://github.com/cesanta/mongoose deps/mongoose

clean:
	rm -f ${OBJ} test

.PHONY: deps
