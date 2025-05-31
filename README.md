---

# WS2812B / WS2815 Driver

A minimal WS2812B LED driver written in AVR assembly.

Designed for 16 MHz AVR microcontrollers, but should work on any chip that supports the required AVR instructions.

Tested on **WS2812B** and **WS2815** LEDs.

---

## Prerequisites

Make sure you have the AVR toolchain installed, including `avr-gcc` and `make`. On Debian-based systems:

```bash
sudo apt install avr-libc gcc-avr make
```

---

## Building

To build the project, simply run:

```bash
make all
```

This will assemble and compile the driver for use with your AVR setup.

---

## References

* **AVR Instruction Set Manual**
  (https://ww1.microchip.com/downloads/en/DeviceDoc/AVR-InstructionSet-Manual-DS40002198.pdf)
  Used as a reference while writing the assembly.

* **WS2812B Datasheet**
  (https://cdn-shop.adafruit.com/datasheets/WS2812B.pdf)
  Useful for understanding timing and protocol requirements.

---