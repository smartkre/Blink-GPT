MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 32K
  RAM (rwx)   : ORIGIN = 0x20000000, LENGTH = 10K
}

SECTIONS
{
  .isr_vector :
  {
    KEEP(*(.isr_vector))
  } > FLASH

  .text :
  {
    *(.text*)
    *(.rodata*)
  } > FLASH

  .data : AT (ADDR(.text) + SIZEOF(.text))
  {
    *(.data*)
  } > RAM

  .bss :
  {
    *(.bss*)
    *(COMMON)
  } > RAM
}
