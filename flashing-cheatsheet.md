Easy way to find device name is to ls /dev before switching controller to boot load and then,
ls /dev once it is recognised, a new device name is highly likely to be the controller.
In this example it became available as sda1.
```shell
cd /home/myuser/vial-qmk/
make clean
make crkbd:vial CONVERT_TO=promicro_rp2040
sudo mkdir /run/media/myuser/promicro
sudo mount /dev/sda1 /run/media/myuser/promicro
sudo cp /home/myuser/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040.uf2 /run/media/myuser/promicro
sudo umount /dev/sda1
sudo rmdir /run/media/myuser/promicro
```

Somehow built in ee hands flashing does not work for me, so I have set up some sh files:
Please note these have hardcoded paths, and you'd need to put your own.

Build
```shell
#!/bin/sh
cd /home/parents/vial-qmk/
make clean
make crkbd:vial CONVERT_TO=promicro_rp2040
sudo mv /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040.uf2 /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040_left.uf2
sed -i -e 's/#define MASTER_LEFT/\/\/#define MASTER_LEFT/g' /home/parents/vial-qmk/keyboards/crkbd/keymaps/vial/config.h
sed -i -e 's/\/\/#define MASTER_RIGHT/#define MASTER_RIGHT/g' /home/parents/vial-qmk/keyboards/crkbd/keymaps/vial/config.h
make crkbd:vial CONVERT_TO=promicro_rp2040
sudo mv /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040.uf2 /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040_right.uf2
sed -i -e 's/#define MASTER_RIGHT/\/\/#define MASTER_RIGHT/g' /home/parents/vial-qmk/keyboards/crkbd/keymaps/vial/config.h
sed -i -e 's/\/\/#define MASTER_LEFT/#define MASTER_LEFT/g' /home/parents/vial-qmk/keyboards/crkbd/keymaps/vial/config.h
```

Flash
```shell
#!/bin/sh
## Assuming that left is already plugged in at this point
echo "Flashing left..."
sudo mkdir -p /run/media/parents/promicro
sudo mount /dev/sda1 /run/media/parents/promicro
sudo cp /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040_left.uf2 /run/media/parents/promicro
echo "Wait for left to re-connect and unplug it."
while true; do
    read -p "Ready to unmount?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
sudo umount /dev/sda1
sudo rmdir /run/media/parents/promicro
echo "Please plug right and make sure it's detected."
while true; do
    read -p "Ready to mount?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
sudo mkdir -p /run/media/parents/promicro
sudo mount /dev/sda1 /run/media/parents/promicro
sudo cp /home/parents/vial-qmk/.build/crkbd_rev1_vial_promicro_rp2040_right.uf2 /run/media/parents/promicro
echo "Wait for right to re-connect and unplug it."
while true; do
    read -p "Ready to unmount?" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
sudo umount /dev/sda1
sudo rmdir /run/media/parents/promicro
```
