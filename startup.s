.syntax unified
.cpu cortex-m3
.thumb

.global Reset_Handler
.global Default_Handler
.global _stack_top

/* Stack top */
.stack_top = 0x20002800

.section .isr_vector, "a", %progbits
.word _stack_top
.word Reset_Handler
.word Default_Handler /* NMI */
.word Default_Handler /* HardFault */
.word Default_Handler /* MemManage */
.word Default_Handler /* BusFault */
.word Default_Handler /* UsageFault */
.word 0
.word 0
.word 0
.word 0
.word Default_Handler /* SVC */
.word Default_Handler /* DebugMon */
.word 0
.word Default_Handler /* PendSV */
.word Default_Handler /* SysTick */

Reset_Handler:
    /* VTOR жёстко в флеш */
    LDR   R0, =0xE000ED08
    LDR   R1, =0x08000000
    STR   R1, [R0]

    /* Минимальная задержка для стабилизации тактирования */
    LDR   R2, =100000
1:  SUBS  R2, R2, #1
    BNE   1b

    /* Переход в main */
    BL main
    B .

Default_Handler:
    B .
