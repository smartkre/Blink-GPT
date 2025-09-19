# Makefile для STM32F103C6T6 с CMSIS include

# Инструменты
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
CFLAGS = -Wall -Wextra -Os -ffreestanding -fno-builtin -mcpu=cortex-m3 -mthumb -IInclude
LDFLAGS = -T STM32F103x6_FLASH.ld -nostdlib -Wl,-Map=build/firmware.map,--gc-sections

SRC = src/main.c src/system_stm32f1xx.c
ASM = src/startup_stm32f103xb.s

BUILD_DIR = build
TARGET = $(BUILD_DIR)/firmware

.PHONY: all clean

all: $(TARGET).bin

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TARGET).elf: $(SRC) $(ASM) | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(SRC) $(ASM) $(LDFLAGS) -o $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

clean:
	rm -rf $(BUILD_DIR)
