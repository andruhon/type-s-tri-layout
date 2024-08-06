/*
Copyright 2019 @foostan
Copyright 2020 Drashna Jaelre <@drashna>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    // BASE
    [0] = LAYOUT_split_3x5_3(
        KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,     KC_U,     KC_I,    KC_O,     KC_P,
        KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                               KC_H,     KC_J,     KC_K,    KC_L,     KC_SCLN,
        KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                               KC_N,     KC_M,     KC_COMM, KC_DOT,   KC_SLSH,
                                KC_LALT, KC_SPC, TL_LOWR,           TL_UPPR, KC_ENT, KC_RCTL
    ),

    // LOWR
    [1] = LAYOUT_split_3x5_3(
        KC_ESC,  KC_F7,   KC_F8,   KC_F9,   KC_F10,                             KC_PGUP,  KC_HOME, KC_UP,   KC_END,   KC_BSPC,
        KC_GRAVE,KC_F4,   KC_F5,   KC_F6,   KC_F11,                             KC_PGDN,  KC_LEFT, KC_DOWN, KC_RIGHT, KC_QUOT,
        KC_LSFT, KC_F1,   KC_F2,   KC_F3,   KC_F12,                             KC_DEL,   KC_TAB,  KC_INS,  KC_APP,   KC_LSFT,
                                KC_LALT, KC_LGUI, _______,           _______,  KC_ENT,  KC_RCTL
    ),

    // UPPR (hold UPPR and N KC_BTN1 to drag and drop)
    [2] = LAYOUT_split_3x5_3(
        KC_ESC,  KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_U,                            KC_MINUS, KC_7,    KC_8,    KC_9,     KC_0,
        KC_GRAVE,KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D,                            KC_EQUAL, KC_4,    KC_5,    KC_6,     KC_DOT,
        KC_LSFT, KC_QUOT, KC_COMM, KC_DOT,  KC_BTN3,                            KC_BTN1,  KC_1,    KC_2,    KC_3,     KC_ACL0,
                                KC_LALT, KC_LCTL, _______,           _______, KC_BTN3, KC_RALT
    ),
    // use ACL0 for precise mouse movements


    // ADJUST (HOLD BOTH LOWR AND UPPR).
    // s, d, f, h, n, k and l are reserved personal macros (those hand-twisting combinations like WIN+SHIFT+S)
    [3] = LAYOUT_split_3x5_3(
        KC_ESC,  DF(0),   DF(1),   DF(2),   KC_VOLU,                            KC_PSCR,  KC_CAPS, XXXXXXX, KC_LBRC,  KC_RBRC,
        KC_TAB,  XXXXXXX, XXXXXXX, XXXXXXX, KC_MUTE,                            XXXXXXX,  KC_QUOT, XXXXXXX, XXXXXXX,  KC_BSLS,
        KC_LSFT, KC_LCTL, KC_LGUI, KC_LALT, KC_VOLD,                            KC_DEL,   KC_RALT, KC_RGUI, KC_RCTL,  KC_RSFT,
                                XXXXXXX, XXXXXXX, _______,           _______,  XXXXXXX,  XXXXXXX
    )
};

#ifdef OLED_ENABLE
#include <stdio.h>

oled_rotation_t oled_init_user(oled_rotation_t rotation) {
  if (!is_keyboard_master()) {
    return OLED_ROTATION_180;  // flips the display 180 degrees if offhand
  }
  return rotation;
}

#define L_BASE 0
#define L_LOWER 2
#define L_RAISE 4
#define L_ADJUST 8

void oled_render_layer_state(void) {
    oled_write_P(PSTR("Layer: "), false);
    switch (layer_state) {
        case L_BASE:
            oled_write_ln_P(PSTR("Default"), false);
            break;
        case L_LOWER:
            oled_write_ln_P(PSTR("Lower"), false);
            break;
        case L_RAISE:
            oled_write_ln_P(PSTR("Raise"), false);
            break;
        case L_ADJUST:
        case L_ADJUST|L_LOWER:
        case L_ADJUST|L_RAISE:
        case L_ADJUST|L_LOWER|L_RAISE:
            oled_write_ln_P(PSTR("Adjust"), false);
            break;
    }
}


char keylog_str[24] = {};

const char code_to_name[60] = {
    ' ', ' ', ' ', ' ', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
    'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
    '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
    'R', 'E', 'B', 'T', '_', '-', '=', '[', ']', '\\',
    '#', ';', '\'', '`', ',', '.', '/', ' ', ' ', ' '};

void set_keylog(uint16_t keycode, keyrecord_t *record) {
  char name = ' ';
    if ((keycode >= QK_MOD_TAP && keycode <= QK_MOD_TAP_MAX) ||
        (keycode >= QK_LAYER_TAP && keycode <= QK_LAYER_TAP_MAX)) { keycode = keycode & 0xFF; }
  if (keycode < 60) {
    name = code_to_name[keycode];
  }

  // update keylog
  snprintf(keylog_str, sizeof(keylog_str), "%dx%d, k%2d : %c",
           record->event.key.row, record->event.key.col,
           keycode, name);
}

void oled_render_keylog(void) {
    oled_write(keylog_str, false);
}

void render_bootmagic_status(bool status) {
    /* Show Ctrl-Gui Swap options */
    static const char PROGMEM logo[][2][3] = {
        {{0x97, 0x98, 0}, {0xb7, 0xb8, 0}},
        {{0x95, 0x96, 0}, {0xb5, 0xb6, 0}},
    };
    if (status) {
        oled_write_ln_P(logo[0][0], false);
        oled_write_ln_P(logo[0][1], false);
    } else {
        oled_write_ln_P(logo[1][0], false);
        oled_write_ln_P(logo[1][1], false);
    }
}

void oled_render_logo(void) {
    static const char PROGMEM crkbd_logo[] = {
        0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, 0x90, 0x91, 0x92, 0x93, 0x94,
        0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7, 0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf, 0xb0, 0xb1, 0xb2, 0xb3, 0xb4,
        0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7, 0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf, 0xd0, 0xd1, 0xd2, 0xd3, 0xd4,
        0};
    oled_write_P(crkbd_logo, false);
}

bool oled_task_user(void) {
    if (is_keyboard_master()) {
        oled_render_layer_state();
        oled_render_keylog();
    } else {
        oled_render_logo();
    }
    return false;
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    set_keylog(keycode, record);
  }
  return true;
}
#endif // OLED_ENABLE
