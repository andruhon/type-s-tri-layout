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

/**
 * Custom macro keycodes
 * Please note it won't show in VIA and VIAL.
 * see process_record_user down below
 */
// enum custom_keycodes {
//   MY_MACRO_S,
//   MY_MACRO_L,
//   MY_MACRO_EN, // Ctrl+Shift+Enter - really helpful in IntelliJ Idea
//   MY_MACRO_CSA // Ctrl+Shift+A     - really helpful in IntelliJ Idea
// };

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
        KC_ESC,  KC_F7,   KC_F8,   KC_F9,   KC_F12,                             KC_PGUP,  KC_HOME, KC_UP,   KC_END,   KC_BSPC,
        KC_GRAVE,KC_F4,   KC_F5,   KC_F6,   KC_F10,                             KC_PGDN,  KC_LEFT, KC_DOWN, KC_RIGHT, KC_QUOT,
        KC_LSFT, KC_F1,   KC_F2,   KC_F3,   KC_F11,                             KC_DEL,   KC_TAB,  KC_INS,  KC_APP,   KC_LSFT,
                                KC_LCTL, KC_LGUI, _______,           _______,  KC_ENT,  KC_RALT
    ),

    // UPPR (hold UPPR and N KC_BTN1 to drag and drop)
    [2] = LAYOUT_split_3x5_3(
        KC_ESC,  KC_BTN2, KC_MS_U, KC_BTN1, KC_WH_U,                            KC_MINUS, KC_7,    KC_8,    KC_9,     KC_BSPC,
        KC_QUOT, KC_MS_L, KC_MS_D, KC_MS_R, KC_WH_D,                            KC_EQUAL, KC_4,    KC_5,    KC_6,     KC_0,
        KC_LSFT, KC_BSLS, KC_COMM, KC_DOT,  KC_BTN3,                            KC_BTN1,  KC_1,    KC_2,    KC_3,     KC_ACL0,
                                KC_LCTL, KC_SPC, _______,            _______,  KC_ENT, KC_RALT
    ),
    // use ACL0 for precise mouse movements


    // ADJUST (HOLD BOTH LOWR AND UPPR).
    // s, d, f, h, n, k and l are reserved personal macros (those hand-twisting combinations like WIN+SHIFT+S)
    [3] = LAYOUT_split_3x5_3(
        KC_ESC,    DF(0),   DF(1),   DF(2), KC_VOLU,                            KC_PSCR,  KC_CAPS, XXXXXXX, KC_LBRC,  XXXXXXX,
        KC_TAB,  XXXXXXX, XXXXXXX, XXXXXXX, KC_MUTE,                            XXXXXXX,  KC_GRAVE,XXXXXXX, XXXXXXX,  KC_RBRC,
        KC_LSFT, KC_LCTL, KC_LALT, KC_LGUI, KC_VOLD,                            KC_DEL,   KC_RGUI, KC_RALT, KC_RCTL,  KC_RSFT,
                                XXXXXXX, XXXXXXX, _______,           _______,  KC_ENT,  XXXXXXX
    )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (record->event.pressed) {
        switch (keycode) {
            // // Uncomment custom_keycodes enum above if you want to uncomment this block
            // case MY_MACRO_S:
            //     // GUI+Shift+s - capture area of screen (in both KDE and windows)
            //     // FIXME this for some reason triggers for any unused adjust key
            //     SEND_STRING(SS_DOWN(X_LGUI)SS_DOWN(X_LSFT)"s"SS_UP(X_LSFT)SS_UP(X_LGUI));
            //     return false;
            // case MY_MACRO_L:
            //     // FIXME this for some reason simply triggers 6 from RISE
            //     SEND_STRING(SS_DOWN(X_LALT)SS_DOWN(X_LSFT)"l"SS_UP(X_LSFT)SS_UP(X_LALT));
            //     return false;
            // case MY_MACRO_EN:
            //     SEND_STRING(SS_DOWN(X_LCTL)SS_DOWN(X_LSFT)SS_TAP(X_ENT)SS_UP(X_LSFT)SS_UP(X_LCTL));
            //     return false;
            // case MY_MACRO_CSA:
            //     SEND_STRING(SS_DOWN(X_LCTL)SS_DOWN(X_LSFT)"a"SS_UP(X_LSFT)SS_UP(X_LCTL));
            //     return false;
            case DF(0):
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR(""), false);
                return false;
            case DF(1):
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR("LOWR LOCK"), false);
                return false;
            case DF(2):
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR(""), false);
                oled_write_ln_P(PSTR("RISE LOCK"), false);
                return false;
        }
    }

    return true;
}
