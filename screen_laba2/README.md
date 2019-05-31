# Отчет по лабораторной работе №2
## Лабораторная работа состоит из 3-х частей:
### 1. Настройка работоспособной системы с использованием lvm, raid
### 2. Эмуляция отказа одного из дисков
### 3. Замена дисков на лету, с добавлением новых дисков и переносом разделов.

## Задание 1 (Установка ОС и настройка LVM, RAID)
#### 1.1 Создайте новую виртуальную машину, выдав ей следующие характеристики:
- 1 gb ram
- 1 cpu
- 2 hdd (назвать их ssd1, ssd2 и назначить равный размер, поставить галочки hot swap и ssd)
- SATA контроллер настроен на 4 порта
# screen
#### 1.2 Выбираем Partitioning method: manual и размечаем диски
- Создаем раздел под /boot с размером 512М
- Для второго диска повторяем настройки, но mount point:none
#screen
- Настраиваем RAID:
    - Свободное место на обоих дисках используем в качестве типа раздела physical volume for RAID
    - В Configure software RAID создаем MD device, device type: RAID1, выбираем оба диска и их разделы, созданные под RAID
    screen
- Настройка LVM:
  - Keep current partition layout and configure LVM: Yes
  - Create volume group
  - Volume group name: system
  - Devices for the new volume group: Выберите ваш созданный RAID
  - Create logical volume
    - logical volume name: root
    - logical volume size: 2\5 от размера диска
  - Create logical volume
    - logical volume name: var
    - logical volume size: 2\5 от размера диска
  - Create logical volume
    - logical volume name: log
    - logical volume size: 1\5 от размера диска
  - Current LVM configuration:
  - Итог настройки LVM
  - Разметка разделов:
    - root -> Use as: ext4, mount point: /
    - var -> Use as: ext4, mount point: /var
    - log -> Use as: ext4, mount point: /var/log
  - Финальный результат:
  #### 1.3 Закончить установку ОС, поставив grub на первое устройство (sda) и загрузить систему.
  #### 1.4 Выполните копирование содержимого раздела /boot с диска sda (ssd1) на диск sdb (ssd2)
  #### 1.5 Выполнить установку grub на второе устройство:
  - посмотреть диски в системе:
    - fdisk -l
    - lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
  - Перечислите все диски которые вам выдала предыдущая команда и опишите что это за диск
  - Найдите диск на который не была выполнена установка grub и выполните эту установку: grub-install /dev/sdb
  - просмотрите информацию о текущем raid командой cat /proc/mdstat и запишите что вы увидели.
  - посмотрите выводы команд: pvs, vgs, lvs, mount и запишите что именно вы увидели
  #### Результат:
  - В ручную настроенны разделы диска
  - Настроенны логические тома (root, var, log), установлены точки монтирования