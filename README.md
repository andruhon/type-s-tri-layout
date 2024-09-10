I realised that I actually don't quite use VIAL, so I decided
to declutter my layout to be QMK only.

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
to make sure the uf2 file is flashed to RPI-RP2
```
qmk flash -kb crkbd -km andruhon -e CONVERT_TO=promicro_rp2040
```
