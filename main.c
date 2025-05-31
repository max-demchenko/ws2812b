#include <avr/io.h>
#include <util/delay.h>

extern void update_leds(uint16_t *ptr_to_array, uint16_t length);

extern void setup_pin();

#define MAX_STRIP_LENGTH 21845

int main(void)
{

    static uint8_t matrix [12] = {
        0xfe, 0x00, 0x00, 
        0x00, 0xff, 0x00,
        0x00, 0x00, 0xff,
        0xff, 0xff, 0xff
    };

    setup_pin();

    while (1)
    {
        update_leds((uint16_t *)matrix, 4 * 3);
        _delay_us(10000);
    }
}
