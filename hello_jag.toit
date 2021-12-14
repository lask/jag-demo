// Copyright (C) 2020 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

import bitmap show *
import color_tft show *
import font show *
import font.x11_100dpi.sans.sans_10 as sans_10
import font.x11_100dpi.sans.sans_24_bold as sans_24_bold
import pictogrammers_icons.size_96 as icons
import gpio
import m5stack_core2
import pixel_display show *
import pixel_display.histogram show TrueColorHistogram
import pixel_display.texture show *
import pixel_display.true_color show *
import spi

main:
  clock := gpio.Pin 22
  data := gpio.Pin 21

  // Create the power object and initialize the power config
  // to its default values.  Resets the LCD display and switches
  // on the LCD backlight and the green power LED.
  power := m5stack_core2.Power --clock=clock --data=data

  // Get TFT driver.
  tft := m5stack_core2.display

  tft.background = get_rgb 0x12 0x03 0x25
  width := 320
  height := 240
  sans := Font [sans_10.ASCII]
  sans_big := Font [sans_24_bold.ASCII]
  sans_big_context := tft.context --landscape --color=WHITE --font=sans_big
  sans_big_blue := tft.context --landscape --alignment=TEXT_TEXTURE_ALIGN_CENTER --color=(get_rgb 0x40 0x40 0xff) --font=sans_big
  sans_context := tft.context --landscape --color=WHITE --font=sans

  ctr := tft.text (sans_big_context.with --alignment=TEXT_TEXTURE_ALIGN_RIGHT) width / 2 height "00000"
  ctr_small := tft.text sans_context width / 2 height "000"

  hello := tft.text sans_big_blue width / 2 height / 2 "Hello, Jag!"

  tft.draw

  icon := tft.icon (tft.context --color=WHITE --alignment=TEXT_TEXTURE_ALIGN_CENTER) width / 2 height / 2 + 48 icons.NUKE


  last := Time.monotonic_us
  while true:
    sleep --ms=1  // Avoid watchdog.
    ctr.text = "$(%05d last / 1000000)"
    ctr_small.text = "$(%03d (last % 1000000) / 1000)"
    tft.draw
    last = Time.monotonic_us
