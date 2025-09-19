CC = arm-none-eabi-gcc
CFLAGS = -Wall -Wextra -Os -ffreestanding -fno-builtin -mcpu=cortex-m3 -mthumb
LDFLAGS = -T stm32f103c6.ld -nostdlib -Wl,-Map=build/firmware.map,--gc-sections -Wl,--gc-sections

SRC = src/startup.s src/main.c
BUILD = build
TARGET = $(BUILD)/firmware

all:
	mkdir -p $(BUILD)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET).elf $(LDFLAGS)
	arm-none-eabi-objcopy -O binary $(TARGET).elf $(TARGET).bin

clean:
	rm -rf $(BUILD)
