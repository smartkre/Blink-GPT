CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -Os -ffreestanding -fno-builtin -mcpu=cortex-m3 -mthumb
LDFLAGS = -T stm32f103c6.ld -nostdlib -Wl,-Map=build/firmware.map,--gc-sections -Wl,--gc-sections

SRC = src/startup.s src/main.c
BUILD = build
TARGET = $(BUILD)/firmware

all:
	mkdir -p build
	arm-none-eabi-gcc -Wall -Wextra -Os -ffreestanding -fno-builtin -mcpu=cortex-m3 -mthumb src/startup.s src/main.c -o build/firmware.elf -T stm32f103c6.ld -nostdlib -Wl,-Map=build/firmware.map,--gc-sections -Wl,--gc-sections
	arm-none-eabi-objcopy -O binary build/firmware.elf build/firmware.bin

clean:
	rm -rf $(BUILD)
