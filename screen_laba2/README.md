# Отчет по лабораторной работе №2
## Лабораторная работа состоит из 3-х частей:
### 1. Настройка работоспособной системы с использованием lvm, raid
### 2. Эмуляция отказа одного из дисков
### 3. Замена дисков на лету, с добавлением новых дисков и переносом разделов.

## Задание 1. Установка ОС и настройка LVM, RAID
#### 1.1 Создайте новую виртуальную машину, выдав ей следующие характеристики:
- 1 gb ram
- 1 cpu
- 2 hdd (назвать их ssd1, ssd2 и назначить равный размер, поставить галочки hot swap и ssd)
- SATA контроллер настроен на 4 порта
- ![](https://pp.userapi.com/c848616/v848616450/199a70/MdKmyIKZBCo.jpg)
- ![](https://pp.userapi.com/c852224/v852224618/123b3c/6_S-AZrjQwI.jpg)
#### 1.2 Выбираем Partitioning method: manual и размечаем диски
- Создаем раздел под /boot с размером 512М
- Для второго диска повторяем настройки, но mount point:none
- ![](https://pp.userapi.com/c852224/v852224618/123b45/EKZ_ZRXb6BU.jpg)
- Настраиваем RAID:
    - Свободное место на обоих дисках используем в качестве типа раздела physical volume for RAID
    - ![](https://pp.userapi.com/c852224/v852224618/123b4e/bDkfY0IdQJ0.jpg)
    - В Configure software RAID создаем MD device, device type: RAID1, выбираем оба диска и их разделы, созданные под RAID
    - ![](https://pp.userapi.com/c852224/v852224618/123b57/tA0J2G_cAqU.jpg)
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

  - Разметка разделов:
    - root -> Use as: ext4, mount point: /
    - var -> Use as: ext4, mount point: /var
    - log -> Use as: ext4, mount point: /var/log
   -![](https://pp.userapi.com/c855028/v855028618/591ac/YhnYuOjfNQE.jpg)
 - Финальный результат:
 -![](https://pp.userapi.com/c852224/v852224618/123b72/tu4SnW6QyWo.jpg)
#### 1.3 Закончить установку ОС, поставив grub на первое устройство (sda) и загрузить систему.
#### 1.4 Выполните копирование содержимого раздела /boot с диска sda (ssd1) на диск sdb (ssd2)
-![](https://pp.userapi.com/c855028/v855028618/591b4/hzBu6IkP_jM.jpg)
#### 1.5 Выполнить установку grub на второе устройство:
- посмотреть диски в системе:
  - fdisk -l
  - lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
-[](https://pp.userapi.com/c855028/v855028618/591ca/XWKXGRxSeuY.jpg)
- Перечислите все диски которые вам выдала предыдущая команда и опишите что это за диск
- Найдите диск на который не была выполнена установка grub и выполните эту установку: grub-install /dev/sdb
-![](https://pp.userapi.com/c855028/v855028618/591bb/xb8FDnz1zKs.jpg)
- просмотрите информацию о текущем raid командой cat /proc/mdstat и запишите что вы увидели.
-![](https://pp.userapi.com/c855028/v855028618/591d3/WzDSXFZ9Gis.jpg)
- посмотрите выводы команд: pvs, vgs, lvs, mount и запишите что именно вы увидели
-![](https://pp.userapi.com/c855028/v855028618/591dc/gWNXZnkttXg.jpg)
-![](https://pp.userapi.com/c848616/v848616450/199a51/7THc0CKOnds.jpg)
#### Результат:
# TODO
- В ручную настроенны разделы диска
- Настроенны логические тома (root, var, log), установлены точки монтирования
  
## Задание 2. Эмуляция отказа одного из дисков
  
#### 2.1 Удалить ssd1 в VМ и удалить файл жесткого диска, затем перезагрузить машину
-![](https://pp.userapi.com/c855028/v855028500/57a8b/1nwJptn4jug.jpg)
#### 2.2 Проверить статус RAID массива
-![](https://pp.userapi.com/c855028/v855028500/57a94/zOP4eci3FdY.jpg)
#### 2.3 Добавляем диск ssd3 и проверяем что за диск пришел в систему:
-![](https://pp.userapi.com/c848616/v848616450/199a77/Bvykvpsdh2A.jpg)
-![](https://pp.userapi.com/c855028/v855028500/57a9d/QUZgBueK4_U.jpg)
-![](https://pp.userapi.com/c855028/v855028500/57abf/myY0dUc4CBA.jpg)
- Копируем таблицу разделов и смотрим результаt
-![](https://pp.userapi.com/c849128/v849128500/1a4502/TLlMqtzYHX4.jpg)
- Добавляем диск в рейд массив
-![](https://pp.userapi.com/c849128/v849128500/1a4509/CWpuBcI7L7k.jpg)
- Смотрим информацию об активных массивах
-![](https://pp.userapi.com/c849128/v849128500/1a4512/BzLJRbkMfhs.jpg)
- Синхронизируем разделы, не входящие в RAID
-![](https://pp.userapi.com/c849128/v849128500/1a451a/dKNMmBlDPJU.jpg)
- Ставим grub на новый диск
-![](https://pp.userapi.com/c849128/v849128500/1a4521/uoKKsAMg55s.jpg)

#### Результат:
# TODO

## Задание 3. Добавление новых дисков и перенос раздела
#### 3.1 Удаляем ssd2 и смотрим что изменилось
-![](https://pp.userapi.com/c849128/v849128500/1a453c/b2-daXo_hHs.jpg)
-![](https://pp.userapi.com/c849128/v849128500/1a4545/T0FOf2s92bM.jpg)
#### 3.2 Добавляем ssd4 и смотрим что изменилось
-![](https://pp.userapi.com/c849128/v849128500/1a454e/1-ZjIa4fG_s.jpg)
#### 3.3 Перенос данных с помощью LVM:
- Копируем файловую таблицу
![](https://pp.userapi.com/c849128/v849128500/1a4556/BraxztNteg8.jpg)
- Копируем данные /boot
![](https://pp.userapi.com/c849128/v849128500/1a455e/8UYx9huzNTs.jpg)
- Ставим boot на новый диск
![](https://pp.userapi.com/c849128/v849128500/1a4566/ucHjho1LJe8.jpg)
- Установка загрузчика для того чтоб загружаться с диска
![](https://pp.userapi.com/c849128/v849128500/1a456d/2ToyM9WmVEs.jpg)
- Создаем новый RAID- массив для диска
-![](https://pp.userapi.com/c849128/v849128500/1a457f/M6xbLagIGmg.jpg)
- Смотрим активные массивы и информацию о дисках, добавился /dev/md63
![](https://pp.userapi.com/c849128/v849128500/1a4588/_nSzJ441pzQ.jpg)
#### 3.4 Настройка LVM:
- Смотрим информацию о физических томах
- Создаем новый том с RAID-массивом
- Смотрим что изменилось
-![](https://pp.userapi.com/c849128/v849128500/1a45b6/EeRDnOsW_Y8.jpg)
- Увеличиваем размер Volume Group System
-![](https://pp.userapi.com/c849128/v849128500/1a45d4/zK-PR-iBSN0.jpg)
- Выполняем команды vgdisplay system -v, pvs, vgs, lvs -a -o+devices
- LV var,log,root находятся на /dev/md0
![](https://pp.userapi.com/c849128/v849128500/1a45e0/xNO01MjroSE.jpg)
![](https://pp.userapi.com/c849128/v849128500/1a45e7/ZpUP7EGVFjc.jpg)
![](https://pp.userapi.com/c849128/v849128500/1a45f0/EQVLwpSHGE0.jpg)
- Перемещаем данные на новый диск
![](https://sun9-1.userapi.com/c849128/v849128500/1a45f8/FX6okFmSMic.jpg)
- Выполняем команды vgdisplay system -v, pvs, vgsЮ lvs -a -o+devices, lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
![](https://pp.userapi.com/c849128/v849128500/1a4600/XzrXS4eh0IE.jpg)
![](https://pp.userapi.com/c849128/v849128500/1a4609/xrDAnyVKnXk.jpg)
- Удаляем диск старого RAID из логического тома
![](https://pp.userapi.com/c849128/v849128500/1a461a/jgx3rtKaRGs.jpg)
- Выполняем команды lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT, pvs, vgs
- Из физических томов у /dev/md0 исчезли VG и Attr. В выводе команды vgs #PV - уменьшилось на 1, VSize, VFree уменьшились.
![](https://pp.userapi.com/c849128/v849128500/1a462b/c1wM5J0-svI.jpg)
- Смотрим список файлов в /boot
![](https://pp.userapi.com/c849128/v849128500/1a4645/dupesFTZC40.jpg)
#### 3.5 Восстановление работы основного RAID- массива после добавления дисков:
![](https://pp.userapi.com/c849128/v849128500/1a465c/AzLoaiWRkd8.jpg)
- Копируем таблицу разделов
![](https://pp.userapi.com/c849128/v849128500/1a466e/rUGgxVHWL8Q.jpg)
- Копируем /boot
- Устанавливаем grub
![](https://pp.userapi.com/c849128/v849128500/1a4676/S6SDsMfYEhw.jpg)
#### 3.6 Меняем размер второго размера диска
- Запускаем fdisk, удаляем второй раздел (d 2)
- Создаем новый первичный раздел со вторым номером (n -> p -> 2)
- Выбираем начало и конец раздела по дефолту
![](https://pp.userapi.com/c849128/v849128500/1a467e/8FuvWSUcN38.jpg)
- Смотрим список всех возможных типов раздела и находим Linux raid auto (fd)
- Меняем тип созданного раздела, пишем измениния на диск (t -> 2 -> fd -> w)
![](https://pp.userapi.com/c849128/v849128732/1aab51/6GMw9Gzk9GI.jpg)
![](https://pp.userapi.com/c849128/v849128732/1aab58/HXLlp9T4p3g.jpg)
- Перечитываем таблицу разделов и смотрим результат
- Добавляем диск к RAID- массиву
![](https://pp.userapi.com/c849128/v849128732/1aab69/fJflkLoLqnA.jpg)
- Расширяем кол-во дисков в массиве до 2 штук
![](https://pp.userapi.com/c849128/v849128732/1aab77/AAcwURx4EFA.jpg)
#### 3.7 Увеличиваем размер раздела на ssd4
- Запускаем fdisk, удаляем второй раздел (d 2)
- Создаем новый первичный раздел со вторым номером (n -> p -> 2)
- Выбираем начало и конец раздела по дефолту
- Оставляем сигнатуру принадлежности раздела к массиву и записываем изменения (No -> w)
![](https://pp.userapi.com/c849128/v849128732/1aab7f/g9BWNGbJ4ho.jpg)
- Перечитываем таблицу разделов и смотрим результат
![](https://pp.userapi.com/c849128/v849128732/1aab96/ddG2kDzbbq4.jpg)
#### 3.8 Разширяем размер RAID
- md127 size 4.5 -> 7.5 GB
![](https://pp.userapi.com/c849128/v849128732/1aaba7/d_bb_-7PSsI.jpg)
#### 3.9 Меняем размеры vg root,var,log
- Смотрим информацию о физических томах, меняем размер и снова проверяем
![](https://pp.userapi.com/c849128/v849128732/1aabb6/NVAOCJBcpbU.jpg)
- Добавляем место для vg var, root
![](https://pp.userapi.com/c849128/v849128732/1aabbf/acaw_9TN0cE.jpg)
#### 3.10 Перемещаем /var/log на новые диски
- Смотрим имена дисков
- Создаем RAID- массив
https://pp.userapi.com/c849128/v849128732/1aabc8/VYlH4t-VRVI.jpg
- Создаем физический раздел на рейде, с группой data
- Создаем логический том var_log
![](https://pp.userapi.com/c849128/v849128732/1aabf9/ocZOE6iXDn8.jpg)
- Форматируем новый раздел в ext4
- Смотрим результат
![](https://pp.userapi.com/c849128/v849128732/1aac01/fFAuVB_jUV0.jpg)
#### 3.11 Перенос логов со старого раздела на новый
- Временно монтируем новое хранилище логов
![](https://pp.userapi.com/c849128/v849128732/1aac0a/BYkWMWclxqA.jpg)
- Синхронизируем разделы
![](https://pp.userapi.com/c849128/v849128732/1aac12/a7vuCLl3D7U.jpg)
![](https://pp.userapi.com/c849128/v849128732/1aac1a/pQcA720rOZY.jpg)
- Смотрим какие процессы работают с /var/log и останавливаем их
![](https://pp.userapi.com/c849128/v849128732/1aac22/6dBS8fjLN2E.jpg)
- Финальная синхронизация
- Меняем местами разделы
![](https://pp.userapi.com/c849128/v849128732/1aac2a/zwG-AsOwb3Y.jpg)
- Смотрим результат
- Правим таблицу файловой системы и монтируем /var/log на устройство data-var_log
![](https://pp.userapi.com/c849128/v849128732/1aac32/jr1xDiOkMtk.jpg)
- Ребут и финальная проверка
![](https://pp.userapi.com/c849128/v849128732/1aac3b/q8l19PPc4Bk.jpg)
![](https://pp.userapi.com/c849128/v849128732/1aac43/s4XDn6ekSQM.jpg)


