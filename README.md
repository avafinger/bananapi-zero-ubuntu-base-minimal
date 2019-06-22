# bananapi-zero-ubuntu-base-minimal
BananaPi M2 Zero  - Ubuntu Xenial Base Minimal Image (Experimental) - U-Boot 2017.09 / Kernel 4.19.y (mainline - stable)

This is a **WiP**, a bare minimum firmware image (CLI - command line interface) with basic configurations. Kernel used is Mainline kernel 4.17.y / 4.18.y / 4.20.y with some patches applied.
The idea behind this firmware is to have a very basic sd card image and add packages to your need.

The Image comes with the minimum packages but you can install a full Desktop on top of this, see how at the end.

* v1 is Kernel 4.15.y

* **v2 is Kernel 4.17.y**

  For convenience, an 8GB SD CARD Image is at https://mega.nz/#!obIAVQiA!G0CCABkLunCcG8hEqMf7NfjTBK1jgMytt2f0VdtOl08

  Use 7zip to unzip it and flash it with **etcher** or win32imagewriter (**Win32DiskImager**)

* **v2 stable kernel 4.17.12 update**

   
		sudo dpkg -i linux-image-4.17.12-m2z_1.0-5.deb


   and then:


		sync && sudo shutdown -h now
		

power cicle the board
	

* **v3 stable kernel 4.18.4 upgrade**

   
		sudo dpkg -i linux-image-4.18.4-m2z_1.0-7.deb


   and then:


		sync && sudo shutdown -h now
		

power cicle the board


* **v4 stable kernel 4.18.8 upgrade**

Before upgrade, get rid of old kernel image not in use and check available space in /boot


		df -lh
		Filesystem      Size  Used Avail Use% Mounted on
		/dev/mmcblk0p2   15G  631M   13G   5% /
		devtmpfs        183M     0  183M   0% /dev
		tmpfs           248M     0  248M   0% /dev/shm
		tmpfs           248M   11M  237M   5% /run
		tmpfs           5.0M     0  5.0M   0% /run/lock
		tmpfs           248M     0  248M   0% /sys/fs/cgroup
		/dev/mmcblk0p1   93M   64M   23M  74% /boot


Make sure you have enough free space left, if not, issue in shell:

		sudo dpkg -l | grep linux-image
		ii  linux-image-4.17.12-m2z           1.0-5                                      armhf        Linux kernel 4.17.12-m2z
		ii  linux-image-4.17.8-m2z            1.0-1                                      armhf        Linux kernel 4.17.8-m2z
		ii  linux-image-4.17.9-m2z            1.0-2                                      armhf        Linux kernel 4.17.9-m2z
		ii  linux-image-4.18.6-m2z-otg-gadget 1.0-11                                     armhf        Linux kernel 4.18.6-m2z-otg-gadget


and check the current kernel you are running:


		uname -r 
		4.18.6-m2z-otg-gadget


so it is safe to get rid of unused kernel and free some space for the new one you want to install:


		sudo dpkg -r linux-image-4.17.12-m2z
		(Reading database ... 35990 files and directories currently installed.)
		Removing linux-image-4.17.12-m2z (1.0-5) ...


and now install the latest kernel:

   
		sudo dpkg -i linux-image-4.18.8-m2z-otg-gadget_1.0-12.deb
		Selecting previously unselected package linux-image-4.18.8-m2z-otg-gadget.
		(Reading database ... 33740 files and directories currently installed.)
		Preparing to unpack linux-image-4.18.8-m2z-otg-gadget_1.0-12.deb ...
		INFO: Updating Kernel 4.18.6-m2z-otg-gadget to 4.18.8-m2z-otg-gadget
		INFO: Updating...
		Unpacking linux-image-4.18.8-m2z-otg-gadget (1.0-12) ...
		Setting up linux-image-4.18.8-m2z-otg-gadget (1.0-12) ...
		OK: Kernel upgrade success! Please reboot with: sync && sudo reboot



and then:




		sync && sudo reboot 




or better 



		sync && sudo shutdown -h now




power cicle the board and check kernel version again:




		uname -r 
		4.18.8-m2z-otg-gadget




		

* **v5 mailine kernel 4.19.0 upgrade**




		sudo dpkg -i linux-image-4.19.0-m2z-otg-gadget_1.0-13.deb
		sync && sudo reboot 




* **v6 mailine kernel 4.19.1 (stable) upgrade**




		sudo dpkg -i linux-image-4.19.1-m2z-otg-gadget_1.0-14.deb
		sync && sudo reboot 



* **v7 mailine kernel 4.20.0-rc2 (mainline) upgrade**




		sudo dpkg -i linux-image-4.20.0-rc2-m2z-otg-gadget_1.0-15.deb
		sync && sudo reboot 



rebuild bpi-m2z_boot.scr with:


		edit bpi-m2-zero_boot.cmd and change:

		setenv extra "no_console_suspend consoleblank=0 drm_leak_fbdev_smem=1"
		setenv bootargs "console=ttyS0,115200 earlyprintk rootfstype=ext4 root=/dev/mmcblk0p2 rw rootwait fsck.repair=${fsck.repair} panic=10 ${extra}"
		bootz ${kernel_addr} ${ramdisk_addr}:${ramdisk_size} ${dtb_addr}


rebuild with:


		sudo mkimage -C none -A arm -T script -d bpi-m2-zero_boot.cmd bpi-m2-zero_boot.scr


* **v8 mailine kernel 4.20.0-rc3 (mainline) upgrade**




		sudo dpkg -i linux-image-4.20.0-rc3-m2z-otg-gadget_1.0-16.deb
		sync && sudo reboot 



* **v9 mailine kernel 4.19.5 (stable) upgrade**



		sudo dpkg -i linux-image-4.19.5-m2z-otg-gadget_1.0-19.deb
		sync && sudo reboot 


* **v10 mailine kernel 4.19.6 (stable) upgrade**

deb file in Release v10, grab the file with: 


		wget https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/releases/download/v10/linux-image-4.19.6-m2z-otg-gadget_1.0-20.deb
		sudo dpkg -i linux-image-4.19.6-m2z-otg-gadget_1.0-20.deb
		sync && sudo reboot 


* **v11 mailine kernel 4.19.12 (stable) upgrade**

deb file in Release v11, grab the file with: 


		wget https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/releases/download/v11/linux-image-4.19.12-m2z-otg-gadget_1.0-21.deb
		sudo dpkg -i linux-image-4.19.12-m2z-otg-gadget_1.0-21.deb
		sync && sudo reboot 


* **v12 mailine kernel 4.20.0 (experimental) upgrade**

deb file in Release v12, grab the file with: 


		wget https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/releases/download/v12/linux-image-4.20.0-m2z-otg-gadget_1.0-22.deb
		sudo dpkg -i linux-image-4.20.0-m2z-otg-gadget_1.0-22.deb
		sync && sudo reboot 

* **v13 mailine kernel 4.20.17-m2z (experimental) upgrade**

    		https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/releases/tag/v13

# Mainline stable Kernel 4.20.17 (Kodi)

This kernel is provided as a **POC** where you can build **Kodi**

Mainline stable kernel 4.20.17 ready to build **Kodi**:

 * Cedrus (VPU)
 * Mali (GBM)
 * hdmi-sound
 * wifi + eth
 * tools to test cedrus and gbm (pre-built)

To test mali GBM you can run **kmscube**
To test cedrus you can run **v4l2-request-test**

# VPU test

Testing cedrus on mainline is quite simple, run the tests below:

    cd v4l2-request-test
    sudo ./v4l2-request-test -l -f 25 -P ed-mpeg2

or

    sudo ./v4l2-request-test -l -f 25 -P caminandes-h265

# Mali GBM test

To test mali GBM you need to setup the mali blobs provided by https://github.com/bootlin/mali-blobs

    sudo ./kmscube

When you run the **kmscube** you will see a cube spinning

 * Tools:

    https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/releases/tag/v14

# hdmi-sound

To be able to acess and output sound to HDMI you need to update the file **/etc/asound.conf**

pcm.!default {
    type plug
    slave {
        pcm "hw:1,0"
    }
}
		
ctl.!default {
   type hw
   card 1
} 

Reboot and test the HDMI sound:

	sudo aplay /usr/share/sounds/alsa/Front_Left.wav


# What's new with this Image v14 (mainline experimental)


   * 4.20.17 (for building Kodi)
   * mali gbm (GPU)
   * cedrus (VPU hw decoding)
   * Wifi + eth
   * hdmi-sound


# What's new with this Image v13 (mainline experimental)


   * 4.20.17-m2z (minimum kernel)
   

# What's new with this Image v12 (mainline experimental)


   * 4.20.0 (for testing)
   * mali (experimental)




# What's new with this Image v11 (LTS experimental)


   * 4.19.12 (for testing)
   * mali (experimental)




# What's new with this Image v10 (LTS experimental)


   * 4.19.6 (for testing)
   * mali (experimental)




# What's new with this Image v9 (LTS experimental)



   * mali fix (mali is back and working!)



# What's new with this Image v8 (experimental)
Image upgraded to **Kernel 4.20-rc3**

 
   * operating-points-v2 (120 Mhz ~ 1008 MHz) - with sane CPU Temp. ( ~ 55.0 C )
   * attempt to make mali work
   * Bluetooth (working) - See Instructions on Bluetooth below


# What's new with this Image v7 (experimental)
Image upgraded to **Kernel 4.20-rc2**

 
   * operating-points-v2 (240 Mhz ~ 1008 MHz) - testing only
   * attempt to make mali work
   * Bluetooth (need to load hci_uart module and install Bluez tools)


# What's new with this Image v6 (experimental)
Image upgraded to **Kernel 4.19.1**

 
   * operating-points-v2 (480 Mhz ~ 1008 MHz)
   * mali removed


# What's new with this Image v5 (experimental)
Image upgraded to **Kernel 4.19.0**

    * operating-points-v2 working as it should (next series will be 4.19.y)
    * new devfreq temp
    * cma memory-reservation for mali (need a revision)

Issue:
	
    * mali does not work, freezes kernel completely (don't use it)



# What's new with this Image v4
Image updated to **Kernel 4.18.8** and has the following working:

    * operating-points-v2 working as it should (next series will be 4.19.y)
    * attempt to get bt working


Configuring ZRAM for the memory hungry stuffs

		sudo apt-get install zram-config
		sync && sudo reboot

On next reboot you will see if ZRAM is active:

		ubuntu@bpi-m2z:~$ ls /dev/zr*
		/dev/zram0  /dev/zram1  /dev/zram2  /dev/zram3


# What's new with this Image v3
Image updated to **Kernel 4.18.4** and has the following working:

    * framebuffer with 1920x1080
    * mali (3D GPU) - fbdev only (Thanks to Maxime Ripard from bootlin)
    * eth0 up
    * wlan0 up
    * i2c enabled ( /dev/i2c-0 and /dev/i2c-1 )
    * spi enabled ( /dev/spidev0.0 )
    * bare minimum image. (**30 Mbytes of RAM used**)
    * new rootfs from scratch
    * ssh enabled
    * new operating-points-v2 instead of old one (experimental)

# What's new with this Image v2
Image updated to **Kernel 4.17.17** and has the following working:

    * framebuffer with 1920x1080
    * mali (3D GPU) - fbdev only (Thanks to Maxime Ripard from bootlin)
    * eth0 up
    * wlan0 up
    * i2c enabled ( /dev/i2c-0 and /dev/i2c-1 )
    * spi enabled ( /dev/spidev0.0 )
    * bare minimum image. (**30 Mbytes of RAM used**)
    * new rootfs from scratch
    * ssh enabled
    * ZRAM / TUN modules enabled (but not configured)

Known issues:
    
    * Hit ENTER twice to see the login prompt if you get a blank screen
    * Boot with your monitor/display turned ON before you power the board
    * HDMI driver is under development, Jernej (the dev. person behind the driver)
      has given some tips to fix this issue.
    * Debian Bug report logs - #892229
      wireless-regdb: Missing support for kernel direct loading
      This seems to affect ubuntu 16.04 and 18.04.
    
To do before first boot:

* edit /etc/network/interfaces and add your SSID and password in order to use connect to your Wifi

Generate wpa-psk for Wifi AP, you can use *wpa_passphrase* from your linux box


Generate like so:


	wpa_passphrase SSID 01234567890


where SSID is your Wifi **SSID** and **01234567890** your password

Edit and change accordingly:


	iface wlan0 inet dhcp
	wpa-ssid SSID
	#psk="1234567890"
	wpa-psk 93c8ff514dc02ae4944f89424d7b0d94f42ab3245cc413755ab655b8e344a2d9
	dns-nameservers 8.8.8.8 8.8.4.4
	wireless-power off




To do after first boot (Advanced users):

    * build regulatory.db to your country for the wifi to get full power

    * re-build wireless-regdb



# Tips

* Board runs at ~60ºC when idle with HDMI, ~40ºC without HDMI enabled (*without heatsink*)

* issue in shell on first login: *sudo apt-get update && sudo apt-get upgrade*

  It is always a good idea to issue a: **sudo shutdown -h now** (and wait for the Red led Heartbeat to stop and only then unplug power)

* If you have trouble with Wifi, i suggest read **Debian Bug report logs - #892229**

  Regulatory.db needs to be generated somehow, until wireless-regdb is updated or rebuild it yourself. 


# Basic instructions to flash firmware to SD CARD

* You need a *linux box*
* You need a *good* SD CARD reader/writer (External SD CARD Reader are known to not be reliable)
  Read some heated up discussion on Armbian's forum about how to write to SD CARD
* Get a trusted brand for the SD CARD

* insert your SD CARD into SDHC reader/writer:

  check which device is your SD CARD, type in shell: 

		dmesg | tail


  An output of USB SDHC reader/writer card 

		[47484.133274]  sdc: sdc1 sdc2
		[47488.681276] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
		[47488.955328] EXT4-fs (sdc2): mounted filesystem without journal. Opts: (null)


  An output of internal SDHC reader/writer card 

		[ 2024.720656] mmc0: new SDHC card at address 59b4
		[ 2024.759743] mmcblk0: mmc0:59b4 SDU1  7.52 GiB 
		[ 2024.759889]  mmcblk0: p1 p2
		[ 2025.140282] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode
		[ 2025.222858] EXT4-fs (mmcblk0p2): mounted filesystem without journal

  Your device will be in the form of: /dev/sd*X* where *X* is your *sd card letter* (b,c,d...) or /dev/mmcblk*Y* where *Y* is your device *number* (0,1,2...)


* format the sd card:

   in the example above, our sd card device is *sdc* (could be **sdb**)

		sudo ./format_sd_mainline.sh /dev/sdc

   or /dev/mmcblk0 if you have SDHC reader on your laptop for example

		sudo ./format_sd_mainline.sh /dev/mmcblk0

# Image v2 (Kernel 4.17.4)

* flash Image to sd card (**ssh enabled**):

		cat rootfs_kernel_4.17.y.tar.gz.* > rootfs_kernel_4.17.y.tar.gz

		sudo ./flash_sdcard_m2z_v2.sh /dev/sdc



# Image v1 (Kernel 4.15.y)

* flash Image to sd card:

		sudo ./flash_sdcard_m2z.sh /dev/sdc

* flash Image with *ssh enabled* to sd card:

		sudo ./flash_sdcard_m2z_ssh.sh


* Booting first time
  
Before you boot, configure your wifi
	

# Connecting to AP via Wifi

Wifi use wpa_supplicant to connect to AP.
Before you boot the Image, please edit **/etc/network/interfaces**


	iface wlan0 inet dhcp
	wpa-ssid SSID <== change this
	#psk="1234567890"
	wpa-psk 93c8ff514dc02ae4944f89424d7b0d94f42ab3245cc413755ab655b8e344a2d9 <== change this
	dns-nameservers 8.8.8.8 8.8.4.4
	wireless-power off



* Login first time

You can login with 

  **user: ubuntu**

  **pasw: ubuntu**

via serial debug or use ssh to connect remotely from your computer.

Conecting via ssh or putty:
ssh ubuntu@IP where IP is the IP assigned to the board.

# First thing you should do on the first login (**for v1 only**)

* fix mv segment fault

	sudo apt-get install --reinstall coreutils

* fix missing service

	sudo apt-get install --reinstall systemd

* disable power management
	
	sudo iwconfig wlan0 power off

or in /etc/network/interfaces add this entry:

    allow-hotplug wlan0
      iface wlan0 inet dhcp
      wpa-ssid your_ssid
      #psk="12345678901234567890"
      wpa-psk ababaf514dc02ae4944f89424d7b0d94f42ab3245cc413755ab655b8e344a2d9
      dns-nameservers 8.8.8.8 8.8.4.4
      wireless-power off <==== add this


reboot now:

	sudo reboot


# Mali benchmark

You can benchmark mali for fbdev, type in shell:

	cd /home/ubuntu/mali/mali-fbdev/build/src
	sudo ./glmark2-es2-fbdev

You can add FRONTBUFFER_LOCKING=1 to prevent tearing before running benchmark:

	export FRONTBUFFER_LOCKING=1


[![mali bechmark screenshot 1](https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/raw/master/img/mali1.png)]

[![mali bechmark screenshot 2](https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/raw/master/img/mali2.png)]

[![mali bechmark screenshot 3](https://github.com/avafinger/bananapi-zero-ubuntu-base-minimal/raw/master/img/mali3.png)]

# Installing a Full Desktop environment

After you setup a connection to internet, you can install a Desktop environment

	sudo apt-get update
	sudo apt-get dist-upgrade
	sync
	sudo apt-get install lxde

Wait until it finished and issue:

	sync
	sudo shutdown -h now (wait for the heartbeat to stop and cut power)

Reboot and you have LXDE Desktop

# Bluetooth

The latest Kernel 4.20.0-rc3 upgrade has Bluetooth working.
To be able to use bluetooth follow this instructions (it should be automated via systemd service but for the sake of 
documentation we do it manually) :

* Install packages

		sudo apt-get install rfkill bluez bluetooth-touch

* Load hci_uart kernel module

Edit the file /etc/modules and add bluetooth & hci_uart & rfcomm:

		# /etc/modules: kernel modules to load at boot time.
		#
		# This file contains the names of kernel modules that should be loaded
		# at boot time, one per line. Lines beginning with "#" are ignored.
		#xradio_wlan
		g_serial
		#xradio_wlan
		brcmfmac
		bluetooth
		hci_uart
		rfcomm


* Boot with the new /etc/modules

* in shell type:

		sudo su (to become root)
		brcm_patchram_plus -d --patchram /lib/firmware/ap6212/bcm43438a1.hcd --enable_hci --bd_addr 11:22:33:44:55:66 --no2bytes --tosleep 5000 /dev/ttyS1

wait untill it finish with **"Done setting line discpline"** (CTRL+C to end) and then:

		hciattach /dev/ttyS1 any

We should have now our Bluetooth ready, you can check:

		hcitool devi
		Devices:
			hci0	11:22:33:44:55:66


# Bluetooth - How to pair a Bluetooth Phone with command line

We are going to test our bluetooth setup conecting our board to a Phone (pair with a Phone).
In a Desktop environment we have Blueman which would do it automagically but installing it would require a lot of packages
and our goal here is to have the minimum installed otherwise you go with a complete Desktop.

For this, it is necessary to install pulseaudio or you will not be able to connect to a phone. 
(i think for keyboard or mouse is ok without pulse).

In order to have pulseaudio working we need to install ALSA and make it work.


		sudo apt-get install alsa-utils alsamixer libasound2 alsa-base


Edit (or create) a file /etc/asound.conf with the content:


		pcm.!default {
		    type hw
		    card 0
		    device 0
		}
		 
		ctl.!default {
		    type hw
		    card 0
		}


sync && reboot.


Check device:


		aplay -l
		**** List of PLAYBACK Hardware Devices ****
		card 0: Codec [H3 Audio Codec], device 0: CDC PCM Codec-0 []
		  Subdevices: 1/1
		  Subdevice #0: subdevice #0




We can check if ALSA is working, type in shell:



		alsamixer
		and un-mute and turn up the Line up and everything



and review:


		sudo amixer
		Simple mixer control 'Line In',0
		  Capabilities: pvolume pvolume-joined pswitch cswitch
		  Playback channels: Front Left - Front Right
		  Capture channels: Front Left - Front Right
		  Limits: Playback 0 - 7
		  Front Left: Playback 5 [71%] [3.00dB] [off] Capture [off]
		  Front Right: Playback 5 [71%] [3.00dB] [off] Capture [off]
		Simple mixer control 'Line Out',0
		  Capabilities: pvolume pvolume-joined pswitch
		  Playback channels: Front Left - Front Right
		  Limits: Playback 0 - 31
		  Mono:
		  Front Left: Playback 25 [81%] [-9.00dB] [on]
		  Front Right: Playback 25 [81%] [-9.00dB] [on]
		Simple mixer control 'Line Out Source',0
		  Capabilities: penum
		  Items: 'Stereo' 'Mono Differential'
		  Item0: 'Stereo'
		  Item1: 'Stereo'
		Simple mixer control 'Mic1',0
		  Capabilities: pvolume pvolume-joined pswitch cswitch
		  Playback channels: Front Left - Front Right
		  Capture channels: Front Left - Front Right
		  Limits: Playback 0 - 7
		  Front Left: Playback 3 [43%] [0.00dB] [off] Capture [off]
		  Front Right: Playback 3 [43%] [0.00dB] [off] Capture [off]
		Simple mixer control 'Mic1 Boost',0
		  Capabilities: volume volume-joined
		  Playback channels: Mono
		  Capture channels: Mono
		  Limits: 0 - 7
		  Mono: 4 [57%] [33.00dB]
		Simple mixer control 'Mic2',0
		  Capabilities: pvolume pvolume-joined pswitch cswitch
		  Playback channels: Front Left - Front Right
		  Capture channels: Front Left - Front Right
		  Limits: Playback 0 - 7
		  Front Left: Playback 3 [43%] [0.00dB] [off] Capture [off]
		  Front Right: Playback 3 [43%] [0.00dB] [off] Capture [off]
		Simple mixer control 'Mic2 Boost',0
		  Capabilities: volume volume-joined
		  Playback channels: Mono
		  Capture channels: Mono
		  Limits: 0 - 7
		  Mono: 4 [57%] [33.00dB]
		Simple mixer control 'Mixer',0
		  Capabilities: cswitch
		  Capture channels: Front Left - Front Right
		  Front Left: Capture [off]
		  Front Right: Capture [off]
		Simple mixer control 'Mixer Reversed',0
		  Capabilities: cswitch
		  Capture channels: Front Left - Front Right
		  Front Left: Capture [off]
		  Front Right: Capture [off]
		Simple mixer control 'ADC Gain',0
		  Capabilities: cvolume cvolume-joined
		  Capture channels: Mono
		  Limits: Capture 0 - 7
		  Mono: Capture 3 [43%] [0.00dB]
		Simple mixer control 'DAC',0
		  Capabilities: pvolume pvolume-joined pswitch
		  Playback channels: Front Left - Front Right
		  Limits: Playback 0 - 63
		  Mono:
		  Front Left: Playback 45 [71%] [-20.88dB] [on]
		  Front Right: Playback 45 [71%] [-20.88dB] [on]
		Simple mixer control 'DAC Reversed',0
		  Capabilities: pswitch
		  Playback channels: Front Left - Front Right
		  Mono:
		  Front Left: Playback [off]
		  Front Right: Playback [off]


Testing ALSA:



		aplay /usr/share/sounds/alsa/Front_Center.wav             
		Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono



Now install pulse:



		sudo apt-get install pulseaudio pulseaudio-module-bluetooth


sync && reboot.


Now check if pulse is running:


		ps -e|grep pulse
		1187 ?        00:00:00 pulseaudio



If everything is OK (if not, you should go back and figure out what went wrong) we can now pair with a phone using bluetooth.
Type in shell (if you have not done this yet):


		sudo su (become root)
		brcm_patchram_plus -d --patchram /lib/firmware/ap6212/bcm43438a1.hcd --enable_hci --bd_addr 11:22:33:44:55:66 --no2bytes --tosleep 5000 /dev/ttyS1
		Done setting line discpline (^C)
		hciattach /dev/ttyS1 any
		hciconfig list
		hci0:	Type: BR/EDR  Bus: UART
			BD Address: 11:22:33:44:55:66  ACL MTU: 1021:8  SCO MTU: 64:1
			UP RUNNING 
			RX bytes:1214 acl:0 sco:0 events:42 errors:0
			TX bytes:756 acl:0 sco:0 commands:42 errors:0
		hciconfig -a
		hci0:	Type: BR/EDR  Bus: UART
			BD Address: 11:22:33:44:55:66  ACL MTU: 1021:8  SCO MTU: 64:1
			UP RUNNING 
			RX bytes:934 acl:0 sco:0 events:39 errors:0
			TX bytes:744 acl:0 sco:0 commands:39 errors:0
			Features: 0xbf 0xfe 0xcf 0xfe 0xdb 0xff 0x7b 0x87
			Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
			Link policy: RSWITCH SNIFF 
			Link mode: SLAVE ACCEPT 
			Name: 'bpi-m2z'
			Class: 0x000000
			Service Classes: Unspecified
			Device Class: Miscellaneous, 
			HCI Version: 4.0 (0x6)  Revision: 0x6a
			LMP Version: 4.0 (0x6)  Subversion: 0x2209
			Manufacturer: Broadcom Corporation (15)



We are ready to pair. Type in shell (with your phone with bluetooth on):

		bluetoothctl -a
		[NEW] Controller 22:22:33:44:55:66 bpi-m2z [default]
		Agent registered
		[bluetooth]# devices
		[bluetooth]# list
		Controller 22:22:33:44:55:66 bpi-m2z [default]
		[bluetooth]# power on
		Changing power on succeeded
		[bluetooth]# agent on
		Agent is already registered
		[bluetooth]# default-agent
		Default agent request successful
		[bluetooth]# scan on
		Discovery started
		[CHG] Controller 22:22:33:44:55:66 Discovering: yes
		[NEW] Device 00:17:CA:F7:38:18 Haier HW-W910
		[bluetooth]# pair 00:17:CA:F7:38:18
		Attempting to pair with 00:17:CA:F7:38:18
		[CHG] Device 00:17:CA:F7:38:18 Connected: yes
		Request confirmation
		[agent] Confirm passkey 736813 (yes/no): yes
		[CHG] Device 00:17:CA:F7:38:18 Modalias: usb:v000Ap0000d0000
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001105-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 0000110a-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001112-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001116-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 0000111f-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 0000112f-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001132-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001200-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
		[CHG] Device 00:17:CA:F7:38:18 Paired: yes
		Pairing successful
		[CHG] Device 00:17:CA:F7:38:18 Connected: no
		[bluetooth]# devices
		Device 00:17:CA:F7:38:18 Haier HW-W910
		[bluetooth]# list
		Controller 22:22:33:44:55:66 bpi-m2z [default]
		[bluetooth]# info 00:17:CA:F7:38:18
		Device 00:17:CA:F7:38:18
			Name: Haier HW-W910
			Alias: Haier HW-W910
			Class: 0x5a020c
			Icon: phone
			Paired: yes
			Trusted: no
			Blocked: no
			Connected: no
			LegacyPairing: no
			UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
			UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
			UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
			UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
			UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
			UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
			UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
			UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
			UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
			UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
			UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
			Modalias: usb:v000Ap0000d0000
			RSSI: -42
		[bluetooth]# list-attributes 00:17:CA:F7:38:18
		[bluetooth]# connect 00:17:CA:F7:38:18
		Attempting to connect to 00:17:CA:F7:38:18
		[CHG] Device 00:17:CA:F7:38:18 Connected: yes
		Connection successful
		[Haier HW-W910]# list-attributes 00:17:CA:F7:38:18
		[Haier HW-W910]# disconnect 00:17:CA:F7:38:18
		Attempting to disconnect from 00:17:CA:F7:38:18
		Successful disconnected
		[CHG] Device 00:17:CA:F7:38:18 Connected: no
		[bluetooth]# list-attributes 00:17:CA:F7:38:18
		[bluetooth]# info 00:17:CA:F7:38:18
		Device 00:17:CA:F7:38:18
			Name: Haier HW-W910
			Alias: Haier HW-W910
			Class: 0x5a020c
			Icon: phone
			Paired: yes
			Trusted: no
			Blocked: no
			Connected: no
			LegacyPairing: no
			UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
			UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
			UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
			UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
			UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
			UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
			UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
			UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
			UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
			UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
			UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
			Modalias: usb:v000Ap0000d0000
			RSSI: -42
		[bluetooth]# connect 00:17:CA:F7:38:18
		Attempting to connect to 00:17:CA:F7:38:18
		[CHG] Device 00:17:CA:F7:38:18 Connected: yes
		Connection successful
		[Haier HW-W910]# trust 00:17:CA:F7:38:18
		[CHG] Device 00:17:CA:F7:38:18 Trusted: yes
		Changing 00:17:CA:F7:38:18 trust succeeded
		[Haier HW-W910]# info 00:17:CA:F7:38:18
		Device 00:17:CA:F7:38:18
			Name: Haier HW-W910
			Alias: Haier HW-W910
			Class: 0x5a020c
			Icon: phone
			Paired: yes
			Trusted: yes
			Blocked: no
			Connected: yes
			LegacyPairing: no
			UUID: OBEX Object Push          (00001105-0000-1000-8000-00805f9b34fb)
			UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
			UUID: A/V Remote Control Target (0000110c-0000-1000-8000-00805f9b34fb)
			UUID: Headset AG                (00001112-0000-1000-8000-00805f9b34fb)
			UUID: NAP                       (00001116-0000-1000-8000-00805f9b34fb)
			UUID: Handsfree Audio Gateway   (0000111f-0000-1000-8000-00805f9b34fb)
			UUID: Phonebook Access Server   (0000112f-0000-1000-8000-00805f9b34fb)
			UUID: Message Access Server     (00001132-0000-1000-8000-00805f9b34fb)
			UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34fb)
			UUID: Generic Access Profile    (00001800-0000-1000-8000-00805f9b34fb)
			UUID: Generic Attribute Profile (00001801-0000-1000-8000-00805f9b34fb)
			Modalias: usb:v000Ap0000d0000
			RSSI: -42
		[Haier HW-W910]# list-attributes 00:17:CA:F7:38:18
		[Haier HW-W910]# untrust 00:17:CA:F7:38:18
		[CHG] Device 00:17:CA:F7:38:18 Trusted: no
		Changing 00:17:CA:F7:38:18 untrust succeeded
		[Haier HW-W910]# disconnect 00:17:CA:F7:38:18
		Attempting to disconnect from 00:17:CA:F7:38:18
		Successful disconnected
		[CHG] Device 00:17:CA:F7:38:18 Connected: no
		[bluetooth]# remove 00:17:CA:F7:38:18
		[DEL] Device 00:17:CA:F7:38:18 Haier HW-W910
		Device has been removed
		[bluetooth]# list
		Controller 22:22:33:44:55:66 bpi-m2z [default]
		[NEW] Device 00:17:CA:F7:38:18 Haier HW-W910
		[bluetooth]# scan off
		[CHG] Device 00:17:CA:F7:38:18 RSSI is nil
		Discovery stopped
		[CHG] Controller 22:22:33:44:55:66 Discovering: no
		[bluetooth]# 
		[bluetooth]# quit
		Agent unregistered
		[DEL] Controller 22:22:33:44:55:66 bpi-m2z [default]
	

And finally you can check the Services of your Bluetooth Phone:

		dptool browse 00:17:CA:F7:38:18|grep "Service Name"
		Service Name: Generic Access Profile
		Service Name: Generic Attribute Profile
		Service Name: Audio Source
		Service Name: AVRCP TG
		Service Name: Voice Gateway
		Service Name: OBEX Object Push
		Service Name: Voice Gateway
		Service Name: OBEX Phonebook Access Server
		Service Name: Network service
		Service Name: SMS/MMS Message Access
		Service Name: Email Message Access


# Enbale Bluetooth on next boot (permanently)

To enable Bluetooth (BT) for every new boot, edit /etc/rc.local and add the command:

		#!/bin/sh -e
		#
		# rc.local
		#
		# This script is executed at the end of each multiuser runlevel.
		# Make sure that the script will "exit 0" on success or any other
		# value on error.
		#
		# In order to enable or disable this script just change the execution
		# bits.
		#
		# By default this script does nothing.
		
		# ------------------------
		# ------ enable BT -------
		# ------------------------
		# borrowed from madscientist42
		# Compute a BD_ADDR.  We're going to use pieces of the device serial number for the LAP part.
		SERIAL=`cat /proc/device-tree/serial-number | cut -c9-`
		B1=`echo $SERIAL | cut -c3-4`
		B2=`echo $SERIAL | cut -c5-6`
		B3=`echo $SERIAL | cut -c7-8`
		BDADDR=`printf b8:27:eb:%02x:%02x:%02x $((0x$B1 ^ 0xaa)) $((0x$B2 ^ 0xaa)) $((0x$B3 ^ 0xaa))`
		brcm_patchram_plus -d --patchram /lib/firmware/ap6212/bcm43438a1.hcd --enable_hci --bd_addr $BDADDR --no2bytes --tosleep 5000 /dev/ttyS1  > /tmp/bt.log 2>&1 &
		# -- BT end --------------
		
		exit 0
		#!/bin/bash


Make sure /etc/rc.local has run permissions:

		sudo chmod +x /etc/rc.local



# Credits
Kernel 4.20.0-rc3 is based on mainline kernel (https://www.kernel.org/) (linux-sunxi effort).

Mali based on MRipard (Bootlin)

Thanks to Nora Lee (FOXCONN) for the sample.


# bootlog of bpi-m2z with Kernel 4.20.0-rc3

	[    0.000000] Booting Linux on physical CPU 0x0
	[    0.000000] Linux version 4.20.0-rc3-m2z-otg-gadget (alex@svn) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #1 SMP Mon Nov 19 19:37:43 -02 2018
	[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
	[    0.000000] CPU: div instructions available: patching division code
	[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
	[    0.000000] OF: fdt: Machine model: Banana Pi M2 Zero
	[    0.000000] Memory policy: Data cache writealloc
	[    0.000000] Reserved memory: created CMA memory pool at 0x4a000000, size 96 MiB
	[    0.000000] OF: reserved mem: initialized node cma@4a000000, compatible id shared-dma-pool
	[    0.000000] On node 0 totalpages: 131072
	[    0.000000]   Normal zone: 1024 pages used for memmap
	[    0.000000]   Normal zone: 0 pages reserved
	[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
	[    0.000000] psci: probing for conduit method from DT.
	[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
	[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x3f4 with crng_init=0
	[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s35020 r8192 d22324 u65536
	[    0.000000] pcpu-alloc: s35020 r8192 d22324 u65536 alloc=16*4096
	[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
	[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
	[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk rootfstype=ext4 root=/dev/mmcblk0p2 rw rootwait fsck.repair=yes panic=10 no_console_suspend consoleblank=0 drm_leak_fbdev_smem=1
	[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
	[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
	[    0.000000] Memory: 407036K/524288K available (8192K kernel code, 341K rwdata, 1960K rodata, 1024K init, 268K bss, 18948K reserved, 98304K cma-reserved, 0K highmem)
	[    0.000000] Virtual kernel memory layout:
	                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
	                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
	                   vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
	                   lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
	                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
	                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
	                     .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
	                     .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
	                     .data : 0x(ptrval) - 0x(ptrval)   ( 342 kB)
	                      .bss : 0x(ptrval) - 0x(ptrval)   ( 269 kB)
	[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
	[    0.000000] rcu: Hierarchical RCU implementation.
	[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
	[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
	[    0.000000] GIC: Using split EOI/Deactivate mode
	[    0.000000] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
	[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
	[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
	[    0.000006] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
	[    0.000018] Switching to timer-based delay loop, resolution 41ns
	[    0.000214] Console: colour dummy device 80x30
	[    0.000267] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
	[    0.000282] pid_max: default: 32768 minimum: 301
	[    0.000433] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
	[    0.000448] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
	[    0.001143] CPU: Testing write buffer coherency: ok
	[    0.001605] CPU0: update cpu_capacity 1024
	[    0.001617] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
	[    0.002178] Setting up static identity map for 0x40100000 - 0x40100060
	[    0.002331] rcu: Hierarchical SRCU implementation.
	[    0.003088] smp: Bringing up secondary CPUs ...
	[    0.013872] CPU1: update cpu_capacity 1024
	[    0.013878] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
	[    0.024754] CPU2: update cpu_capacity 1024
	[    0.024760] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
	[    0.035538] CPU3: update cpu_capacity 1024
	[    0.035543] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
	[    0.035629] smp: Brought up 1 node, 4 CPUs
	[    0.035658] SMP: Total of 4 processors activated (192.00 BogoMIPS).
	[    0.035665] CPU: All CPU(s) started in HYP mode.
	[    0.035671] CPU: Virtualization extensions available.
	[    0.036727] devtmpfs: initialized
	[    0.043445] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
	[    0.043696] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
	[    0.043722] futex hash table entries: 1024 (order: 4, 65536 bytes)
	[    0.047452] pinctrl core: initialized pinctrl subsystem
	[    0.048536] NET: Registered protocol family 16
	[    0.050400] DMA: preallocated 256 KiB pool for atomic coherent allocations
	[    0.051329] cpuidle: using governor menu
	[    0.051686] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
	[    0.051696] hw-breakpoint: maximum watchpoint size is 8 bytes.
	[    0.069898] SCSI subsystem initialized
	[    0.070151] libata version 3.00 loaded.
	[    0.070373] usbcore: registered new interface driver usbfs
	[    0.070421] usbcore: registered new interface driver hub
	[    0.070503] usbcore: registered new device driver usb
	[    0.070816] pps_core: LinuxPPS API ver. 1 registered
	[    0.070824] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
	[    0.070850] PTP clock support registered
	[    0.071236] Advanced Linux Sound Architecture Driver Initialized.
	[    0.072602] clocksource: Switched to clocksource arch_sys_counter
	[    0.072746] VFS: Disk quotas dquot_6.6.0
	[    0.072813] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
	[    0.080888] NET: Registered protocol family 2
	[    0.081871] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
	[    0.081901] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
	[    0.081953] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
	[    0.082017] TCP: Hash tables configured (established 4096 bind 4096)
	[    0.082147] UDP hash table entries: 256 (order: 1, 8192 bytes)
	[    0.082194] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
	[    0.082449] NET: Registered protocol family 1
	[    0.083046] RPC: Registered named UNIX socket transport module.
	[    0.083059] RPC: Registered udp transport module.
	[    0.083065] RPC: Registered tcp transport module.
	[    0.083071] RPC: Registered tcp NFSv4.1 backchannel transport module.
	[    0.083755] Unpacking initramfs...
	[    0.127611] Freeing initrd memory: 960K
	[    0.129426] Initialise system trusted keyrings
	[    0.129818] workingset: timestamp_bits=30 max_order=17 bucket_order=0
	[    0.137120] squashfs: version 4.0 (2009/01/31) Phillip Lougher
	[    0.138629] NFS: Registering the id_resolver key type
	[    0.138670] Key type id_resolver registered
	[    0.138676] Key type id_legacy registered
	[    0.138693] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
	[    0.138702] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
	[    0.139599] fuse init (API version 7.28)
	[    0.140049] SGI XFS with ACLs, security attributes, realtime, no debug enabled
	[    0.148962] Key type asymmetric registered
	[    0.148986] Asymmetric key parser 'x509' registered
	[    0.149085] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
	[    0.149098] io scheduler noop registered
	[    0.149104] io scheduler deadline registered
	[    0.149331] io scheduler cfq registered (default)
	[    0.149342] io scheduler mq-deadline registered
	[    0.149350] io scheduler kyber registered
	[    0.150418] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
	[    0.154712] sun8i-h3-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
	[    0.156494] sun8i-h3-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
	[    0.205952] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
	[    0.208391] printk: console [ttyS0] disabled
	[    0.228619] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 44, base_baud = 1500000) is a U6_16550A
	[    0.950227] printk: console [ttyS0] enabled
	[    0.975650] 1c28400.serial: ttyS1 at MMIO 0x1c28400 (irq = 45, base_baud = 1500000) is a U6_16550A
	[    0.997540] sun4i-drm display-engine: bound 1100000.mixer (ops 0xc095568c)
	[    1.004716] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xc095275c)
	[    1.012419] sun8i-dw-hdmi 1ee0000.hdmi: 1ee0000.hdmi supply hvcc not found, using dummy regulator
	[    1.021366] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regulator.0
	[    1.029143] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
	[    1.039027] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
	[    1.046829] sun4i-drm display-engine: bound 1ee0000.hdmi (ops 0xc0955034)
	[    1.053635] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
	[    1.060240] [drm] No driver support for vblank timestamp query.
	[    1.268718] random: fast init done
	[    1.599232] Console: switching to colour frame buffer device 240x67
	[    1.638833] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
	[    1.646284] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
	[    1.657027] libphy: Fixed MDIO Bus: probed
	[    1.661316] CAN device driver interface
	[    1.665835] dwmac-sun8i 1c30000.ethernet: PTP uses main clock
	[    1.671616] dwmac-sun8i 1c30000.ethernet: No regulator found
	[    1.677662] dwmac-sun8i 1c30000.ethernet: No HW DMA feature register supported
	[    1.684900] dwmac-sun8i 1c30000.ethernet: RX Checksum Offload Engine supported
	[    1.692124] dwmac-sun8i 1c30000.ethernet: COE Type 2
	[    1.697094] dwmac-sun8i 1c30000.ethernet: TX Checksum insertion supported
	[    1.703897] dwmac-sun8i 1c30000.ethernet: Normal descriptors
	[    1.709557] dwmac-sun8i 1c30000.ethernet: Chain mode enabled
	[    1.715365] libphy: stmmac: probed
	[    1.719299] dwmac-sun8i 1c30000.ethernet: Found internal PHY node
	[    1.725528] libphy: mdio_mux: probed
	[    1.729119] dwmac-sun8i 1c30000.ethernet: Switch mux to internal PHY
	[    1.735484] dwmac-sun8i 1c30000.ethernet: Powering internal PHY
	[    1.742359] libphy: mdio_mux: probed
	[    1.746460] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
	[    1.752997] ehci-platform: EHCI generic platform driver
	[    1.758425] ehci-platform 1c1a000.usb: EHCI Host Controller
	[    1.764033] ehci-platform 1c1a000.usb: new USB bus registered, assigned bus number 1
	[    1.772190] ehci-platform 1c1a000.usb: irq 27, io mem 0x01c1a000
	[    1.802613] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
	[    1.808902] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
	[    1.817177] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    1.824409] usb usb1: Product: EHCI Host Controller
	[    1.829281] usb usb1: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ehci_hcd
	[    1.836330] usb usb1: SerialNumber: 1c1a000.usb
	[    1.841429] hub 1-0:1.0: USB hub found
	[    1.845232] hub 1-0:1.0: 1 port detected
	[    1.850060] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
	[    1.856279] ohci-platform: OHCI generic platform driver
	[    1.861687] ohci-platform 1c1a400.usb: Generic Platform OHCI controller
	[    1.868330] ohci-platform 1c1a400.usb: new USB bus registered, assigned bus number 2
	[    1.876364] ohci-platform 1c1a400.usb: irq 28, io mem 0x01c1a400
	[    1.946763] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.20
	[    1.955045] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    1.962268] usb usb2: Product: Generic Platform OHCI controller
	[    1.968196] usb usb2: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ohci_hcd
	[    1.975254] usb usb2: SerialNumber: 1c1a400.usb
	[    1.980284] hub 2-0:1.0: USB hub found
	[    1.984076] hub 2-0:1.0: 1 port detected
	[    1.988900] usbcore: registered new interface driver cdc_acm
	[    1.994590] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
	[    2.002648] usbcore: registered new interface driver usblp
	[    2.008177] usbcore: registered new interface driver cdc_wdm
	[    2.013919] usbcore: registered new interface driver usb-storage
	[    2.020023] usbcore: registered new interface driver ch341
	[    2.025556] usbserial: USB Serial support registered for ch341-uart
	[    2.031847] usbcore: registered new interface driver cp210x
	[    2.037452] usbserial: USB Serial support registered for cp210x
	[    2.043433] usbcore: registered new interface driver ftdi_sio
	[    2.049204] usbserial: USB Serial support registered for FTDI USB Serial Device
	[    2.056626] usbcore: registered new interface driver pl2303
	[    2.062215] usbserial: USB Serial support registered for pl2303
	[    2.068917] mousedev: PS/2 mouse device common for all mice
	[    2.075219] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
	[    2.082002] sun6i-rtc 1f00000.rtc: RTC enabled
	[    2.086731] i2c /dev entries driver
	[    2.092535] thermal thermal_zone0: failed to read out thermal zone (-16)
	[    2.099901] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
	[    2.109005] sunxi-mmc 1c0f000.mmc: Linked as a consumer to regulator.2
	[    2.141438] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB
	[    2.148808] sunxi-mmc 1c10000.mmc: Linked as a consumer to regulator.2
	[    2.156082] sunxi-mmc 1c10000.mmc: allocated mmc-pwrseq
	[    2.185330] sunxi-mmc 1c10000.mmc: initialized, max. request size: 16384 KB
	[    2.193708] ledtrig-cpu: registered to indicate activity on CPUs
	[    2.199989] hidraw: raw HID events driver (C) Jiri Kosina
	[    2.205826] usbcore: registered new interface driver usbhid
	[    2.211424] usbhid: USB HID core driver
	[    2.218165] sun4i-codec 1c22c00.codec: ASoC: codec-analog@1f015c0 not registered
	[    2.219174] mmc0: host does not support reading read-only switch, assuming write-enable
	[    2.225590] sun4i-codec 1c22c00.codec: Failed to register our card
	[    2.227243] Initializing XFRM netlink socket
	[    2.235622] mmc0: new high speed SDHC card at address 59b4
	[    2.239822] NET: Registered protocol family 17
	[    2.245682] mmcblk0: mmc0:59b4 SDU1  7.52 GiB 
	[    2.249611] can: controller area network core (rev 20170425 abi 9)
	[    2.256018]  mmcblk0: p1 p2
	[    2.258645] NET: Registered protocol family 29
	[    2.266951] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
	[    2.267550] can: raw protocol (rev 20170425)
	[    2.273511] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
	[    2.277463] can: broadcast manager protocol (rev 20170425 t)
	[    2.283214] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
	[    2.287203] can: netlink gateway (rev 20170425) max_hops=1
	[    2.295540] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
	[    2.299215] rfkill_gpio rfkill_bt: sunxi-bt device registered.
	[    2.307111] mmc1: queuing unknown CIS tuple 0x81 (9 bytes)
	[    2.309579] 9pnet: Installing 9P2000 support
	[    2.324938] Key type dns_resolver registered
	[    2.329439] Registering SWP/SWPB emulation handler
	[    2.334843] Loading compiled-in X.509 certificates
	[    2.347548] cam: supplied by vcc5v0
	[    2.351808] cam-avdd: supplied by cam
	[    2.355557] cam-dovdd: supplied by cam
	[    2.359343] cam-dvdd: supplied by cam
	[    2.364536] ehci-platform 1c1b000.usb: EHCI Host Controller
	[    2.370140] ehci-platform 1c1b000.usb: new USB bus registered, assigned bus number 3
	[    2.378396] ehci-platform 1c1b000.usb: irq 29, io mem 0x01c1b000
	[    2.398114] mmc1: new high speed SDIO card at address 0001
	[    2.412620] ehci-platform 1c1b000.usb: USB 2.0 started, EHCI 1.00
	[    2.418918] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
	[    2.427193] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.434419] usb usb3: Product: EHCI Host Controller
	[    2.439292] usb usb3: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ehci_hcd
	[    2.446342] usb usb3: SerialNumber: 1c1b000.usb
	[    2.451420] hub 3-0:1.0: USB hub found
	[    2.455216] hub 3-0:1.0: 1 port detected
	[    2.459940] ehci-platform 1c1c000.usb: EHCI Host Controller
	[    2.465553] ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 4
	[    2.473608] ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
	[    2.502616] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
	[    2.508856] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
	[    2.517130] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.524354] usb usb4: Product: EHCI Host Controller
	[    2.529227] usb usb4: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ehci_hcd
	[    2.536276] usb usb4: SerialNumber: 1c1c000.usb
	[    2.541290] hub 4-0:1.0: USB hub found
	[    2.545081] hub 4-0:1.0: 1 port detected
	[    2.549700] ehci-platform 1c1d000.usb: EHCI Host Controller
	[    2.555308] ehci-platform 1c1d000.usb: new USB bus registered, assigned bus number 5
	[    2.563406] ehci-platform 1c1d000.usb: irq 33, io mem 0x01c1d000
	[    2.592613] ehci-platform 1c1d000.usb: USB 2.0 started, EHCI 1.00
	[    2.598845] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
	[    2.607115] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.614342] usb usb5: Product: EHCI Host Controller
	[    2.619214] usb usb5: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ehci_hcd
	[    2.626262] usb usb5: SerialNumber: 1c1d000.usb
	[    2.631285] hub 5-0:1.0: USB hub found
	[    2.635076] hub 5-0:1.0: 1 port detected
	[    2.639693] ohci-platform 1c1b400.usb: Generic Platform OHCI controller
	[    2.646349] ohci-platform 1c1b400.usb: new USB bus registered, assigned bus number 6
	[    2.654358] ohci-platform 1c1b400.usb: irq 30, io mem 0x01c1b400
	[    2.726765] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.20
	[    2.735041] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.742254] usb usb6: Product: Generic Platform OHCI controller
	[    2.748181] usb usb6: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ohci_hcd
	[    2.755232] usb usb6: SerialNumber: 1c1b400.usb
	[    2.760259] hub 6-0:1.0: USB hub found
	[    2.764054] hub 6-0:1.0: 1 port detected
	[    2.768682] ohci-platform 1c1c400.usb: Generic Platform OHCI controller
	[    2.775333] ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 7
	[    2.783334] ohci-platform 1c1c400.usb: irq 32, io mem 0x01c1c400
	[    2.856757] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.20
	[    2.865026] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.872238] usb usb7: Product: Generic Platform OHCI controller
	[    2.878163] usb usb7: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ohci_hcd
	[    2.885211] usb usb7: SerialNumber: 1c1c400.usb
	[    2.890204] hub 7-0:1.0: USB hub found
	[    2.893994] hub 7-0:1.0: 1 port detected
	[    2.898656] ohci-platform 1c1d400.usb: Generic Platform OHCI controller
	[    2.905304] ohci-platform 1c1d400.usb: new USB bus registered, assigned bus number 8
	[    2.913297] ohci-platform 1c1d400.usb: irq 34, io mem 0x01c1d400
	[    2.986793] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.20
	[    2.995076] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    3.002289] usb usb8: Product: Generic Platform OHCI controller
	[    3.008216] usb usb8: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget ohci_hcd
	[    3.015272] usb usb8: SerialNumber: 1c1d400.usb
	[    3.020347] hub 8-0:1.0: USB hub found
	[    3.024139] hub 8-0:1.0: 1 port detected
	[    3.028883] usb_phy_generic usb_phy_generic.3.auto: usb_phy_generic.3.auto supply vcc not found, using dummy regulator
	[    3.039657] usb_phy_generic usb_phy_generic.3.auto: Linked as a consumer to regulator.0
	[    3.048029] musb-hdrc musb-hdrc.4.auto: MUSB HDRC host driver
	[    3.053798] musb-hdrc musb-hdrc.4.auto: new USB bus registered, assigned bus number 9
	[    3.061779] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.20
	[    3.070056] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    3.077278] usb usb9: Product: MUSB HDRC host driver
	[    3.082238] usb usb9: Manufacturer: Linux 4.20.0-rc3-m2z-otg-gadget musb-hcd
	[    3.089285] usb usb9: SerialNumber: musb-hdrc.4.auto
	[    3.094716] hub 9-0:1.0: USB hub found
	[    3.098495] hub 9-0:1.0: 1 port detected
	[    3.103139] cpu cpu0: Linked as a consumer to regulator.8
	[    3.108593] cpu cpu0: Dropping the link to regulator.8
	[    3.113933] cpu cpu0: Linked as a consumer to regulator.8
	[    3.121144] sun4i-codec 1c22c00.codec: ASoC: Failed to create component debugfs directory
	[    3.131748] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
	[    3.140681] sun6i-rtc 1f00000.rtc: setting system clock to 1970-01-01 00:00:09 UTC (9)
	[    3.155809] cfg80211: Loading compiled-in X.509 certificates for regulatory database
	[    3.168145] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
	[    3.178491] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
	[    3.180801] vcc3v0: disabling
	[    3.187360] platform regulatory.0: Falling back to syfs fallback for: regulatory.db
	[    3.190307] vcc5v0: disabling
	[    3.200934] cam-avdd: disabling
	[    3.204604] cam-dovdd: disabling
	[    3.208160] cam-dvdd: disabling
	[    3.211459] ALSA device list:
	[    3.214431]   #0: H3 Audio Codec
	[    3.219984] Freeing unused kernel memory: 1024K
	[    3.253946] Run /init as init process
	[    3.594710] usb 1-1: new high-speed USB device number 2 using ehci-platform
	[    3.597365] EXT4-fs (mmcblk0p2): mounted filesystem without journal. Opts: (null)
	[    3.794928] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
	[    3.803205] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
	[    3.810388] usb 1-1: Product: USB2.0 Hub
	[    3.815584] hub 1-1:1.0: USB hub found
	[    3.821038] hub 1-1:1.0: 4 ports detected
	[    4.152684] usb 1-1.2: new high-speed USB device number 3 using ehci-platform
	[    4.279191] systemd[1]: System time before build time, advancing clock.
	[    4.328486] usb 1-1.2: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice= 9.01
	[    4.336887] usb 1-1.2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
	[    4.344218] usb 1-1.2: Product: USB2.0 Hub
	[    4.349604] hub 1-1.2:1.0: USB hub found
	[    4.354342] hub 1-1.2:1.0: 4 ports detected
	[    4.653016] NET: Registered protocol family 10
	[    4.722232] Segment Routing with IPv6
	[    4.722718] usb 1-1.2.3: new low-speed USB device number 4 using ehci-platform
	[    4.761011] random: systemd: uninitialized urandom read (16 bytes read)
	[    4.776589] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
	[    4.795876] systemd[1]: Detected architecture arm.
	[    4.853992] systemd[1]: Set hostname to <nanopi-duo>.
	[    4.901619] usb 1-1.2.3: New USB device found, idVendor=1c4f, idProduct=0002, bcdDevice= 1.10
	[    4.910179] usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
	[    4.917682] usb 1-1.2.3: Product: USB Keyboard
	[    4.922128] usb 1-1.2.3: Manufacturer: SIGMACHIP
	[    4.971346] input: SIGMACHIP USB Keyboard as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.0/0003:1C4F:0002.0001/input/input0
	[    4.974065] random: systemd: uninitialized urandom read (16 bytes read)
	[    5.055034] hid-generic 0003:1C4F:0002.0001: input,hidraw0: USB HID v1.10 Keyboard [SIGMACHIP USB Keyboard] on usb-1c1a000.usb-1.2.3/input0
	[    5.062380] random: systemd-gpt-aut: uninitialized urandom read (16 bytes read)
	[    5.079213] input: SIGMACHIP USB Keyboard Consumer Control as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.1/0003:1C4F:0002.0002/input/input1
	[    5.163697] input: SIGMACHIP USB Keyboard System Control as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.1/0003:1C4F:0002.0002/input/input2
	[    5.180901] hid-generic 0003:1C4F:0002.0002: input,hidraw1: USB HID v1.10 Device [SIGMACHIP USB Keyboard] on usb-1c1a000.usb-1.2.3/input1
	[    5.304755] usb 1-1.2.4: new low-speed USB device number 5 using ehci-platform
	[    5.451765] usb 1-1.2.4: New USB device found, idVendor=1bcf, idProduct=0007, bcdDevice= 0.10
	[    5.460466] usb 1-1.2.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
	[    5.468421] usb 1-1.2.4: Product: USB Optical Mouse
	[    5.482692] input: USB Optical Mouse as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4:1.0/0003:1BCF:0007.0003/input/input3
	[    5.496087] input: USB Optical Mouse as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4:1.0/0003:1BCF:0007.0003/input/input4
	[    5.520418] hid-generic 0003:1BCF:0007.0003: input,hiddev96,hidraw2: USB HID v1.10 Mouse [USB Optical Mouse] on usb-1c1a000.usb-1.2.4/input0
	[    5.837758] systemd[1]: Listening on Journal Socket.
	[    5.914407] systemd[1]: Reached target Remote File Systems (Pre).
	[    5.937931] systemd[1]: Listening on udev Control Socket.
	[    5.983265] systemd[1]: Started Trigger resolvconf update for networkd DNS.
	[    6.013319] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
	[    6.054594] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
	[    6.104286] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
	[    6.706757] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
	[    6.835752] g_serial gadget: Gadget Serial v2.4
	[    6.840303] g_serial gadget: g_serial ready
	[    6.902950] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
	[    6.985436] Bluetooth: Core ver 2.22
	[    6.989175] NET: Registered protocol family 31
	[    6.993826] Bluetooth: HCI device and connection manager initialized
	[    7.000509] Bluetooth: HCI socket layer initialized
	[    7.005468] Bluetooth: L2CAP socket layer initialized
	[    7.010572] Bluetooth: SCO socket layer initialized
	[    7.023201] Bluetooth: HCI UART driver ver 2.3
	[    7.028050] Bluetooth: HCI UART protocol H4 registered
	[    7.033226] Bluetooth: HCI UART protocol BCSP registered
	[    7.038535] Bluetooth: HCI UART protocol ATH3K registered
	[    7.044231] Bluetooth: HCI UART protocol Intel registered
	[    7.049630] Bluetooth: HCI UART protocol AG6XX registered
	[    7.055066] Bluetooth: HCI UART protocol Marvell registered
	[    7.087649] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
	[    7.098671] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
	[    7.112736] brcmfmac mmc1:0001:1: Falling back to syfs fallback for: brcm/brcmfmac43430-sdio.clm_blob
	[    8.034398] systemd-journald[192]: Received request to flush runtime journal from PID 1
	[    8.307647] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-11), device may have limited channels available
	[    8.311894] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Mar 30 2016 11:30:56 version 7.45.77.h8.4 FWID 01-ee8a6268
	[    8.468024] cfg80211: failed to load regulatory.db
	[    8.777141] media: Linux media interface: v0.10
	[    8.791229] mali: loading out-of-tree module taints kernel.
	[    8.802801] Allwinner sunXi mali glue initialized
	[    8.804860] Registered IR keymap rc-empty
	[    8.805108] rc rc0: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0
	[    8.805556] input: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0/input5
	[    8.806450] rc rc0: lirc_dev: driver sunxi-ir registered at minor = 0, raw IR receiver, no transmitter
	[    8.811998] Mali: 
	[    8.812008] Found Mali GPU Mali-400 MP r1p1
	[    8.812725] sunxi-ir 1f02000.ir: initialized sunXi IR driver
	[    8.816537] videodev: Linux video capture interface: v2.00
	[    8.847290] ov5640 2-003c: Linked as a consumer to regulator.5
	[    8.847385] ov5640 2-003c: Linked as a consumer to regulator.6
	[    8.847472] ov5640 2-003c: Linked as a consumer to regulator.4
	[    8.850168] Mali: 
	[    8.850180] 2+0 PP cores initialized
	[    8.851383] Mali: 
	[    8.851390] Mali device driver loaded
	[    8.880132] ov5640 2-003c: ov5640_read_reg: error: reg=300a
	[    8.885969] ov5640 2-003c: ov5640_check_chip_id: failed to read chip identifier
	[    8.893761] ov5640 2-003c: Dropping the link to regulator.5
	[    8.893853] ov5640 2-003c: Dropping the link to regulator.6
	[    8.893914] ov5640 2-003c: Dropping the link to regulator.4
	[    9.941571] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
	[   10.912016] Generic PHY 0.1:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0.1:01, irq=POLL)
	[   10.925866] dwmac-sun8i 1c30000.ethernet eth0: No Safety Features support found
	[   10.925896] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
	[   10.925918] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
	[   10.927314] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
	[   11.141416] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
	[   12.003556] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
	[   12.003643] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
	[   12.798637] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
	[   56.711762] random: crng init done
	[   56.711814] random: 7 urandom warning(s) missed due to ratelimiting
	[  521.245276] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
	[  521.245291] Bluetooth: BNEP filters: protocol multicast
	[  521.245324] Bluetooth: BNEP socket layer initialized
	[  525.482009] Bluetooth: hci0: sending frame failed (-49)
	[  668.728660] Bluetooth: hci0: last event is not cmd complete (0x0f)

