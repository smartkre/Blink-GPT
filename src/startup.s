.syntax unified
.cpu cortex-m3
.thumb

.global _start
.global Reset_Handler
.global _stack_top

.section .isr_vector,"a",%progbits
.word _stack_top
.word Reset_Handler

.section .text
Reset_Handler:
    ldr r0, =_sbss
    ldr r1, =_ebss
    movs r2, #0
zero_bss:
    cmp r0, r1
    it lt
    strlt r2, [r0], #4
    blt zero_bss

    ldr r0, =_sdata
    ldr r1, =_edata
    ldr r2, =_etext
copy_data:
    cmp r0, r1
    it lt
    ldrlt r3, [r2], #4
    strlt r3, [r0], #4
    blt copy_data

    bl main
loop:
    b loop
