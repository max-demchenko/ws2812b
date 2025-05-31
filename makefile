MCU   = atmega328p
F_CPU = 16000000UL  
BAUD  = 9600UL



CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
AVRSIZE = avr-size
AVRDUDE = avrdude 

CFLAGS=-Os -DF_CPU=16000000UL -mmcu=atmega328p


all: main.o ws2812b.o firmware.elf firmware.hex flash 

flash: firmware.hex
	sudo ${AVRDUDE} -c usbasp -p m328p -U flash:w:./build/firmware.hex

firmware.hex: firmware.elf 
	${OBJCOPY} ./build/firmware.elf -O ihex ./build/firmware.hex

firmware.elf: ws2812b.o main.o
	${CC} ${CFLAGS} ./build/main.o ./build/ws2812b.o -o ./build/firmware.elf

ws2812b.o: ws2812b.S
	${CC} -Wall -Os ${CFLAGS} -c ws2812b.S -o ./build/ws2812b.o

main.o: main.c
	${CC} -Wall -Os ${CFLAGS} -c main.c -o ./build/main.o

clean:
	rm -f build/*