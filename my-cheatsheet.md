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
