// Copyright (C) 2020 Toitware ApS.
// Use of this source code is governed by a Zero-Clause BSD license that can
// be found in the EXAMPLES_LICENSE file.

import color_tft show *
import pictogrammers_icons.size_96 as icons
import gpio
import m5stack_core2
import pixel_display show *
import pixel_display.texture show *
import pixel_display.true_color show *

//ICONS ::= {[0xf1210, icons.ICON_RANGE_F1210_F1217_], [0xf1218, icons.ICON_RANGE_F1218_F121F_], [0xf1238, icons.ICON_RANGE_F1218_F121F_]}

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


  icon_context := tft.context --color=WHITE --alignment=TEXT_TEXTURE_ALIGN_LEFT
  tft_icons := []
  tft_icons.add
    tft.icon icon_context 96 96 icons.FLASH
  tft_icons.add
    tft.icon icon_context 96 * 2 96 icons.CLOUD
  tft_icons.add
    tft.icon icon_context 96 * 3 96 icons.COMPARE
  tft_icons.add
    tft.icon icon_context width / 2 height / 2 + 48 icons.FLASH
  tft_icons.add
    tft.icon icon_context width / 2 height / 2 + 48 icons.FLASH
  tft_icons.add
    tft.icon icon_context width / 2 height / 2 + 48 icons.FLASH
  tft_icons.add
    tft.icon icon_context width / 2 height / 2 + 48 icons.FLASH

  tft.draw
  while true:
    // ICONS.do:
      tft.draw
      sleep --ms=2_000
