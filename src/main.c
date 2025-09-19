#include <stdint.h>

#define PERIPH_BASE       0x40000000U
#define APB2PERIPH_BASE   (PERIPH_BASE + 0x10000U)
#define AHBPERIPH_BASE    (PERIPH_BASE + 0x20000U)

#define RCC_BASE          (AHBPERIPH_BASE + 0x1000U)
#define GPIOC_BASE        (APB2PERIPH_BASE + 0x1000U)

#define RCC_APB2ENR       (*(volatile uint32_t*)(RCC_BASE + 0x18U))
#define GPIOC_CRH         (*(volatile uint32_t*)(GPIOC_BASE + 0x04U))
#define GPIOC_ODR         (*(volatile uint32_t*)(GPIOC_BASE + 0x0CU))

static void delay(volatile uint32_t count) {
    while(count--) __asm__("nop");
}

int main(void) {
    // Enable GPIOC clock
    RCC_APB2ENR |= (1 << 4);

    // PC13 as push-pull output
    GPIOC_CRH &= ~(0xF << 20);
    GPIOC_CRH |=  (0x1 << 20);

    while (1) {
        GPIOC_ODR ^= (1 << 13);
        delay(150000);
    }
}
