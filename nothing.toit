import gpio
import m5stack_core2
import pixel_display.true_color show *

main:
  clock := gpio.Pin 22
  data := gpio.Pin 21

  // Create the power object and initialize the power config
  // to its default values.  Resets the LCD display and switches
  // on the LCD backlight and the green power LED.
  power := m5stack_core2.Power --clock=clock --data=data
  power.peripherals --off
  power.led --off
  // // Get TFT driver.
  // tft := m5stack_core2.display

  // tft.background = get_rgb 0x12 0x03 0x25
  // tft.draw
