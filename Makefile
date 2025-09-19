CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -Os -ffreestanding -fno-builtin -mcpu=cortex-m3 -mthumb
LDFLAGS = -T stm32f103c6.ld -nostdlib -Wl,-Map=build/firmware.map,--gc-sections

SRC = src/startup.s src/main.c
OBJ = $(SRC:.c=.o)
OBJ := $(OBJ:.s=.o)

all: build/firmware.elf build/firmware.bin

build/firmware.elf: $(SRC) stm32f103c6.ld | build
	$(CC) $(CFLAGS) $(SRC) -o $@ $(LDFLAGS)

build/firmware.bin: build/firmware.elf
	arm-none-eabi-objcopy -O binary $< $@

build:
	mkdir -p build

clean:
	rm -rf build
