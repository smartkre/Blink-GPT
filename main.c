#include <stdint.h>

#define RCC_APB2ENR   (*(volatile uint32_t*)0x40021018)
#define GPIOC_CRH     (*(volatile uint32_t*)0x40011004)
#define GPIOC_ODR     (*(volatile uint32_t*)0x4001100C)

void delay(volatile uint32_t d) { while(d--); }

int main(void)
{
    /* Включаем тактирование GPIOC */
    RCC_APB2ENR |= (1 << 4);

    /* Настраиваем PC13 как push-pull output, max 50MHz */
    GPIOC_CRH &= ~(0xF << 20); /* очищаем CNF и MODE */
    GPIOC_CRH |=  (0x3 << 20); /* MODE13=11 -> Output max 50MHz */

    while(1)
    {
        GPIOC_ODR ^= (1 << 13);  /* Toggle PC13 */
        delay(500000);
    }
}
