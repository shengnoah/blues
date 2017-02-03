LUALIB=-I/usr/include/lua5.1 -L/usr/local/lib -ldl -lm

.PHONY: all win linux

all:
	@echo Please do \'make PLATFROM\' where PLATFORM is one of these;
	@echo win linux

win:

linux: libtangguo.so

libtangguo.so : tangguo.c
	#gcc --shared -Wall -fPIC -O2 $^ -o $@ $(LUALIB)
	gcc --shared -fPIC -O2 $^ -o $@ $(LUALIB)

install:
	sudo cp libtangguo.so /usr/lib
	sudo ldconfig	
clean:
	rm -f libtangguo.so
