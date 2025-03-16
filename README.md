# TypeS Tri Layout
34 Keys [Tri Layout](https://docs.qmk.fm/features/tri_layer) for QMK optimized for TypeScript and Java.

This layout has customizable keycaps project optimized for 3D printing https://github.com/andruhon/super-custom-keycaps

## Setting up
Install QMK following https://docs.qmk.fm/newbs_getting_started
```
qmk config user.keyboard=crkbd
qmk config user.keymap=andruhon
qmk new-keymap -kb crkbd
```

## Compile
My controller is promicro_rp2040, so I have to use CONVERT_TO,
to make sure the uf2 file produced.
```
qmk compile -kb crkbd -km andruhon -e CONVERT_TO=promicro_rp2040
```

## Flash
My controller is promicro_rp2040, so I have to use CONVERT_TO,
to make sure the uf2 file is flashed to RPI-RP2.

EE_HANDS is enabled, so both halves may be flashed.

Flash left:
```
qmk flash -kb crkbd -km andruhon -bl uf2-split-left -e CONVERT_TO=promicro_rp2040
```

Flash right:
```
qmk flash -kb crkbd -km andruhon -bl uf2-split-right -e CONVERT_TO=promicro_rp2040
```

## Keyboard matrix and layout

### Layout
WIP, check [keymap.c](keymap.c) for full layout for now.
![Layout](keyboard-layout-inkscape.png)

### Matrix
Generated with http://www.keyboard-layout-editor.com/.
See also [Matrix](matrix.json)
![Matrix](matrix.png)

### Notes
The old VIAL stuff can be found in [VIAL](https://github.com/andruhon/corne3x5/tree/vial) branch.
