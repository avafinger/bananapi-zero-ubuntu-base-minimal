# bananapi-zero-ubuntu-base-minimal
BananaPi M2 Zero  - Ubuntu Xenial Base Minimal Image (Experimental) - U-Boot 2017.09 / Kernel 4.18.y (mainline)

This is a **WiP**, a bare minimum firmware image (CLI - command line interface) with basic configurations. Kernel used is Mainline kernel 4.17.4 with some patches applied.
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


* **v4 stable kernel 4.18.6 upgrade**

   
		sudo dpkg -i linux-image-4.18.6-m2z-otg-gadget_1.0-11.deb


   and then:


		sync && sudo shutdown -h now
		

power cicle the board


# What's new with this Image v4
Image updated to **Kernel 4.18.6** and has the following working:

    * operating-points-v2 working as it should (next series will be 4.19.y)
    * attempt to get bt working



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


# Credits
Kernel 4.17.12 based on mainline kernel (https://www.kernel.org/) (linux-sunxi effort).

Mali based on MRipard (Bootlin)

Thanks to Nora Lee (FOXCONN) for the sample.


# bootlog of bpi-m2z with Kernel 4.17.4

	[    0.000000] Booting Linux on physical CPU 0x0
	[    0.000000] Linux version 4.17.4-m2z (alex@svn) (gcc version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #1 SMP Fri Jul 6 00:43:46 -03 2018
	[    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
	[    0.000000] CPU: div instructions available: patching division code
	[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
	[    0.000000] OF: fdt: Machine model: Banana Pi M2 Zero
	[    0.000000] Memory policy: Data cache writealloc
	[    0.000000] cma: Reserved 128 MiB at 0x55c00000
	[    0.000000] On node 0 totalpages: 131072
	[    0.000000]   Normal zone: 1024 pages used for memmap
	[    0.000000]   Normal zone: 0 pages reserved
	[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
	[    0.000000] psci: probing for conduit method from DT.
	[    0.000000] psci: Using PSCI v0.1 Function IDs from DT
	[    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s34508 r8192 d22836 u65536
	[    0.000000] pcpu-alloc: s34508 r8192 d22836 u65536 alloc=16*4096
	[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
	[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
	[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk rootfstype=ext4 root=/dev/mmcblk0p2 rw rootwait fsck.repair=yes no_console_suspend consoleblank=0 panic=10
	[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
	[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
	[    0.000000] Memory: 374220K/524288K available (8192K kernel code, 336K rwdata, 1908K rodata, 1024K init, 263K bss, 18996K reserved, 131072K cma-reserved, 0K highmem)
	[    0.000000] Virtual kernel memory layout:
	                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
	                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
	                   vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
	                   lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
	                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
	                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
	                     .text : 0x(ptrval) - 0x(ptrval)   (9184 kB)
	                     .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
	                     .data : 0x(ptrval) - 0x(ptrval)   ( 337 kB)
	                      .bss : 0x(ptrval) - 0x(ptrval)   ( 264 kB)
	[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
	[    0.000000] Hierarchical RCU implementation.
	[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
	[    0.000000] GIC: Using split EOI/Deactivate mode
	[    0.000000] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
	[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
	[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
	[    0.000007] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
	[    0.000018] Switching to timer-based delay loop, resolution 41ns
	[    0.000235] Console: colour dummy device 80x30
	[    0.000274] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
	[    0.000288] pid_max: default: 32768 minimum: 301
	[    0.000432] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
	[    0.000445] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
	[    0.001119] CPU: Testing write buffer coherency: ok
	[    0.001619] CPU0: update cpu_capacity 1024
	[    0.001631] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
	[    0.002088] Setting up static identity map for 0x40100000 - 0x40100060
	[    0.002214] Hierarchical SRCU implementation.
	[    0.002972] smp: Bringing up secondary CPUs ...
	[    0.013725] CPU1: update cpu_capacity 1024
	[    0.013732] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
	[    0.024608] CPU2: update cpu_capacity 1024
	[    0.024614] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
	[    0.035371] CPU3: update cpu_capacity 1024
	[    0.035376] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
	[    0.035453] smp: Brought up 1 node, 4 CPUs
	[    0.035483] SMP: Total of 4 processors activated (192.00 BogoMIPS).
	[    0.035489] CPU: All CPU(s) started in HYP mode.
	[    0.035494] CPU: Virtualization extensions available.
	[    0.036489] devtmpfs: initialized
	[    0.042263] random: get_random_u32 called from bucket_table_alloc+0x7c/0x190 with crng_init=0
	[    0.042794] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
	[    0.043045] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
	[    0.043068] futex hash table entries: 1024 (order: 4, 65536 bytes)
	[    0.047912] pinctrl core: initialized pinctrl subsystem
	[    0.049001] NET: Registered protocol family 16
	[    0.050834] DMA: preallocated 256 KiB pool for atomic coherent allocations
	[    0.051707] cpuidle: using governor menu
	[    0.052022] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
	[    0.052031] hw-breakpoint: maximum watchpoint size is 8 bytes.
	[    0.067675] cam-avdd: supplied by vcc3v3
	[    0.067901] cam-dovdd: supplied by vcc3v3
	[    0.068149] cam-dvdd: supplied by vcc3v3
	[    0.068435] gpio-regulator gpio-regulator: could not find pctldev for node /soc/pinctrl@1f02c00/regulator_pins@0, deferring probe
	[    0.068810] SCSI subsystem initialized
	[    0.069042] libata version 3.00 loaded.
	[    0.069238] usbcore: registered new interface driver usbfs
	[    0.069297] usbcore: registered new interface driver hub
	[    0.069378] usbcore: registered new device driver usb
	[    0.069662] pps_core: LinuxPPS API ver. 1 registered
	[    0.069671] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
	[    0.069692] PTP clock support registered
	[    0.070066] Advanced Linux Sound Architecture Driver Initialized.
	[    0.071196] clocksource: Switched to clocksource arch_sys_counter
	[    0.071364] VFS: Disk quotas dquot_6.6.0
	[    0.071437] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
	[    0.078856] NET: Registered protocol family 2
	[    0.079718] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
	[    0.079750] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
	[    0.079803] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
	[    0.079865] TCP: Hash tables configured (established 4096 bind 4096)
	[    0.079997] UDP hash table entries: 256 (order: 1, 8192 bytes)
	[    0.080046] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
	[    0.080285] NET: Registered protocol family 1
	[    0.080779] RPC: Registered named UNIX socket transport module.
	[    0.080791] RPC: Registered udp transport module.
	[    0.080796] RPC: Registered tcp transport module.
	[    0.080801] RPC: Registered tcp NFSv4.1 backchannel transport module.
	[    0.081541] Unpacking initramfs...
	[    0.124655] Freeing initrd memory: 956K
	[    0.126384] Initialise system trusted keyrings
	[    0.126755] workingset: timestamp_bits=30 max_order=17 bucket_order=0
	[    0.133229] squashfs: version 4.0 (2009/01/31) Phillip Lougher
	[    0.134632] NFS: Registering the id_resolver key type
	[    0.134685] Key type id_resolver registered
	[    0.134693] Key type id_legacy registered
	[    0.134710] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
	[    0.134717] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
	[    0.135545] fuse init (API version 7.26)
	[    0.135966] SGI XFS with ACLs, security attributes, realtime, no debug enabled
	[    0.140752] Key type asymmetric registered
	[    0.140772] Asymmetric key parser 'x509' registered
	[    0.140891] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
	[    0.140903] io scheduler noop registered
	[    0.140909] io scheduler deadline registered
	[    0.141101] io scheduler cfq registered (default)
	[    0.141110] io scheduler mq-deadline registered
	[    0.141116] io scheduler kyber registered
	[    0.142290] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
	[    0.146361] sun8i-h3-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
	[    0.148002] sun8i-h3-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
	[    0.195112] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
	[    0.197561] console [ttyS0] disabled
	[    0.217754] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 45, base_baud = 1500000) is a U6_16550A
	[    0.939730] console [ttyS0] enabled
	[    0.964406] 1c28400.serial: ttyS1 at MMIO 0x1c28400 (irq = 46, base_baud = 1500000) is a U6_16550A
	[    0.996145] 1c28800.serial: ttyS2 at MMIO 0x1c28800 (irq = 47, base_baud = 1500000) is a U6_16550A
	[    1.017735] sun4i-drm display-engine: bound 1100000.mixer (ops 0xc09541cc)
	[    1.024877] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
	[    1.032718] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xc0951a24)
	[    1.041234] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
	[    1.051035] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
	[    1.058781] sun4i-drm display-engine: bound 1ee0000.hdmi (ops 0xc0953d2c)
	[    1.065578] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
	[    1.072195] [drm] No driver support for vblank timestamp query.
	[    1.280390] random: fast init done
	[    1.609908] Console: switching to colour frame buffer device 240x67
	[    1.649476] sun4i-drm display-engine: fb0:  frame buffer device
	[    1.655834] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
	[    1.667182] libphy: Fixed MDIO Bus: probed
	[    1.671455] CAN device driver interface
	[    1.675868] dwmac-sun8i 1c30000.ethernet: PTP uses main clock
	[    1.681668] dwmac-sun8i 1c30000.ethernet: No regulator found
	[    1.687674] dwmac-sun8i 1c30000.ethernet: Chain mode enabled
	[    1.693350] dwmac-sun8i 1c30000.ethernet: No HW DMA feature register supported
	[    1.700562] dwmac-sun8i 1c30000.ethernet: Normal descriptors
	[    1.706225] dwmac-sun8i 1c30000.ethernet: RX Checksum Offload Engine supported
	[    1.713465] dwmac-sun8i 1c30000.ethernet: COE Type 2
	[    1.718423] dwmac-sun8i 1c30000.ethernet: TX Checksum insertion supported
	[    1.725376] libphy: stmmac: probed
	[    1.729272] dwmac-sun8i 1c30000.ethernet: Found internal PHY node
	[    1.735475] libphy: mdio_mux: probed
	[    1.739062] dwmac-sun8i 1c30000.ethernet: Switch mux to internal PHY
	[    1.745426] dwmac-sun8i 1c30000.ethernet: Powering internal PHY
	[    1.752276] libphy: mdio_mux: probed
	[    1.756271] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
	[    1.762811] ehci-platform: EHCI generic platform driver
	[    1.768214] ehci-platform 1c1a000.usb: EHCI Host Controller
	[    1.773822] ehci-platform 1c1a000.usb: new USB bus registered, assigned bus number 1
	[    1.781986] ehci-platform 1c1a000.usb: irq 27, io mem 0x01c1a000
	[    1.811209] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
	[    1.817478] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
	[    1.825755] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    1.832977] usb usb1: Product: EHCI Host Controller
	[    1.837849] usb usb1: Manufacturer: Linux 4.17.4-m2z ehci_hcd
	[    1.843595] usb usb1: SerialNumber: 1c1a000.usb
	[    1.848684] hub 1-0:1.0: USB hub found
	[    1.852487] hub 1-0:1.0: 1 port detected
	[    1.857253] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
	[    1.863470] ohci-platform: OHCI generic platform driver
	[    1.868849] ohci-platform 1c1a400.usb: Generic Platform OHCI controller
	[    1.875490] ohci-platform 1c1a400.usb: new USB bus registered, assigned bus number 2
	[    1.883459] ohci-platform 1c1a400.usb: irq 28, io mem 0x01c1a400
	[    1.955346] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
	[    1.963622] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    1.970835] usb usb2: Product: Generic Platform OHCI controller
	[    1.976761] usb usb2: Manufacturer: Linux 4.17.4-m2z ohci_hcd
	[    1.982511] usb usb2: SerialNumber: 1c1a400.usb
	[    1.987492] hub 2-0:1.0: USB hub found
	[    1.991282] hub 2-0:1.0: 1 port detected
	[    1.996047] usbcore: registered new interface driver cdc_acm
	[    2.001722] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
	[    2.009763] usbcore: registered new interface driver usblp
	[    2.015288] usbcore: registered new interface driver cdc_wdm
	[    2.021012] usbcore: registered new interface driver usb-storage
	[    2.027107] usbcore: registered new interface driver ch341
	[    2.032623] usbserial: USB Serial support registered for ch341-uart
	[    2.038919] usbcore: registered new interface driver cp210x
	[    2.044524] usbserial: USB Serial support registered for cp210x
	[    2.050485] usbcore: registered new interface driver ftdi_sio
	[    2.056260] usbserial: USB Serial support registered for FTDI USB Serial Device
	[    2.063677] usbcore: registered new interface driver pl2303
	[    2.069263] usbserial: USB Serial support registered for pl2303
	[    2.075933] mousedev: PS/2 mouse device common for all mice
	[    2.082174] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
	[    2.088956] sun6i-rtc 1f00000.rtc: RTC enabled
	[    2.093626] i2c /dev entries driver
	[    2.098724] thermal thermal_zone0: failed to read out thermal zone (-16)
	[    2.106036] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
	[    2.140887] sunxi-mmc 1c0f000.mmc: base:0x(ptrval) irq:24
	[    2.147302] sunxi-mmc 1c10000.mmc: allocated mmc-pwrseq
	[    2.176503] sunxi-mmc 1c10000.mmc: base:0x(ptrval) irq:25
	[    2.183125] ledtrig-cpu: registered to indicate activity on CPUs
	[    2.189360] hidraw: raw HID events driver (C) Jiri Kosina
	[    2.195163] usbcore: registered new interface driver usbhid
	[    2.200753] usbhid: USB HID core driver
	[    2.206586] sun4i-codec 1c22c00.codec: ASoC: codec-analog@1f015c0 not registered
	[    2.214018] mmc0: host does not support reading read-only switch, assuming write-enable
	[    2.214021] sun4i-codec 1c22c00.codec: Failed to register our card
	[    2.215473] Initializing XFRM netlink socket
	[    2.232555] NET: Registered protocol family 17
	[    2.232590] mmc0: new high speed SDHC card at address 59b4
	[    2.237029] can: controller area network core (rev 20170425 abi 9)
	[    2.243861] mmcblk0: mmc0:59b4 SDU1  7.41 GiB 
	[    2.248855] NET: Registered protocol family 29
	[    2.257680] can: raw protocol (rev 20170425)
	[    2.262079] can: broadcast manager protocol (rev 20170425 t)
	[    2.262218]  mmcblk0: p1 p2
	[    2.267775] can: netlink gateway (rev 20170425) max_hops=1
	[    2.276535] 9pnet: Installing 9P2000 support
	[    2.280850] Key type dns_resolver registered
	[    2.285361] Registering SWP/SWPB emulation handler
	[    2.290711] Loading compiled-in X.509 certificates
	[    2.298251] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
	[    2.304607] ehci-platform 1c1b000.usb: EHCI Host Controller
	[    2.310223] ehci-platform 1c1b000.usb: new USB bus registered, assigned bus number 3
	[    2.318336] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
	[    2.318675] ehci-platform 1c1b000.usb: irq 29, io mem 0x01c1b000
	[    2.331082] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
	[    2.339265] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
	[    2.348081] mmc1: queuing unknown CIS tuple 0x81 (9 bytes)
	[    2.351198] ehci-platform 1c1b000.usb: USB 2.0 started, EHCI 1.00
	[    2.359843] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
	[    2.368131] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.375362] usb usb3: Product: EHCI Host Controller
	[    2.380239] usb usb3: Manufacturer: Linux 4.17.4-m2z ehci_hcd
	[    2.386000] usb usb3: SerialNumber: 1c1b000.usb
	[    2.391097] hub 3-0:1.0: USB hub found
	[    2.394901] hub 3-0:1.0: 1 port detected
	[    2.399618] ehci-platform 1c1c000.usb: EHCI Host Controller
	[    2.405256] ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 4
	[    2.413332] ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
	[    2.441202] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
	[    2.447454] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
	[    2.455739] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.462970] usb usb4: Product: EHCI Host Controller
	[    2.467852] usb usb4: Manufacturer: Linux 4.17.4-m2z ehci_hcd
	[    2.473608] usb usb4: SerialNumber: 1c1c000.usb
	[    2.478646] hub 4-0:1.0: USB hub found
	[    2.482441] hub 4-0:1.0: 1 port detected
	[    2.487051] ehci-platform 1c1d000.usb: EHCI Host Controller
	[    2.492665] ehci-platform 1c1d000.usb: new USB bus registered, assigned bus number 5
	[    2.500697] ehci-platform 1c1d000.usb: irq 33, io mem 0x01c1d000
	[    2.531198] ehci-platform 1c1d000.usb: USB 2.0 started, EHCI 1.00
	[    2.537428] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
	[    2.545706] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.552945] usb usb5: Product: EHCI Host Controller
	[    2.557822] usb usb5: Manufacturer: Linux 4.17.4-m2z ehci_hcd
	[    2.563576] usb usb5: SerialNumber: 1c1d000.usb
	[    2.568572] hub 5-0:1.0: USB hub found
	[    2.572367] hub 5-0:1.0: 1 port detected
	[    2.576955] ohci-platform 1c1b400.usb: Generic Platform OHCI controller
	[    2.583607] ohci-platform 1c1b400.usb: new USB bus registered, assigned bus number 6
	[    2.591629] ohci-platform 1c1b400.usb: irq 30, io mem 0x01c1b400
	[    2.622643] mmc1: new high speed SDIO card at address 0001
	[    2.665355] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
	[    2.673643] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.680847] usb usb6: Product: Generic Platform OHCI controller
	[    2.686784] usb usb6: Manufacturer: Linux 4.17.4-m2z ohci_hcd
	[    2.692536] usb usb6: SerialNumber: 1c1b400.usb
	[    2.697520] hub 6-0:1.0: USB hub found
	[    2.701323] hub 6-0:1.0: 1 port detected
	[    2.705944] ohci-platform 1c1c400.usb: Generic Platform OHCI controller
	[    2.712594] ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 7
	[    2.720625] ohci-platform 1c1c400.usb: irq 32, io mem 0x01c1c400
	[    2.795360] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
	[    2.803647] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.810865] usb usb7: Product: Generic Platform OHCI controller
	[    2.816801] usb usb7: Manufacturer: Linux 4.17.4-m2z ohci_hcd
	[    2.822565] usb usb7: SerialNumber: 1c1c400.usb
	[    2.827550] hub 7-0:1.0: USB hub found
	[    2.831348] hub 7-0:1.0: 1 port detected
	[    2.835930] ohci-platform 1c1d400.usb: Generic Platform OHCI controller
	[    2.842584] ohci-platform 1c1d400.usb: new USB bus registered, assigned bus number 8
	[    2.850571] ohci-platform 1c1d400.usb: irq 34, io mem 0x01c1d400
	[    2.925340] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 4.17
	[    2.933619] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    2.940843] usb usb8: Product: Generic Platform OHCI controller
	[    2.946780] usb usb8: Manufacturer: Linux 4.17.4-m2z ohci_hcd
	[    2.952545] usb usb8: SerialNumber: 1c1d400.usb
	[    2.957541] hub 8-0:1.0: USB hub found
	[    2.961343] hub 8-0:1.0: 1 port detected
	[    2.965957] usb_phy_generic usb_phy_generic.3.auto: usb_phy_generic.3.auto supply vcc not found, using dummy regulator
	[    2.977091] musb-hdrc musb-hdrc.4.auto: MUSB HDRC host driver
	[    2.982870] musb-hdrc musb-hdrc.4.auto: new USB bus registered, assigned bus number 9
	[    2.990845] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.17
	[    2.999121] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
	[    3.006358] usb usb9: Product: MUSB HDRC host driver
	[    3.011337] usb usb9: Manufacturer: Linux 4.17.4-m2z musb-hcd
	[    3.017088] usb usb9: SerialNumber: musb-hdrc.4.auto
	[    3.022476] hub 9-0:1.0: USB hub found
	[    3.026272] hub 9-0:1.0: 1 port detected
	[    3.032883] sun4i-codec 1c22c00.codec: ASoC: Failed to create component debugfs directory
	[    3.043518] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
	[    3.052406] sun6i-rtc 1f00000.rtc: setting system clock to 1970-01-01 00:00:06 UTC (6)
	[    3.060544] cfg80211: Loading compiled-in X.509 certificates for regulatory database
	[    3.071216] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
	[    3.077888] vcc3v0: disabling
	[    3.080856] vcc5v0: disabling
	[    3.083970] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
	[    3.091205] cam-avdd: disabling
	[    3.092597] platform regulatory.0: Falling back to user helper
	[    3.095707] cam-dovdd: disabling
	[    3.104794] cam-dvdd: disabling
	[    3.107935] ALSA device list:
	[    3.110897]   #0: H3 Audio Codec
	[    3.116351] Freeing unused kernel memory: 1024K
	[    3.430172] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
	[    3.521317] usb 1-1: new high-speed USB device number 2 using ehci-platform
	[    3.733114] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
	[    3.741403] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
	[    3.748551] usb 1-1: Product: USB2.0 Hub
	[    3.753984] hub 1-1:1.0: USB hub found
	[    3.758122] hub 1-1:1.0: 4 ports detected
	[    4.091270] usb 1-1.2: new high-speed USB device number 3 using ehci-platform
	[    4.109969] systemd[1]: System time before build time, advancing clock.
	[    4.252989] usb 1-1.2: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice= 9.01
	[    4.261373] usb 1-1.2: New USB device strings: Mfr=0, Product=1, SerialNumber=0
	[    4.268682] usb 1-1.2: Product: USB2.0 Hub
	[    4.274101] hub 1-1.2:1.0: USB hub found
	[    4.276360] NET: Registered protocol family 10
	[    4.282597] hub 1-1.2:1.0: 4 ports detected
	[    4.333894] Segment Routing with IPv6
	[    4.388062] random: systemd: uninitialized urandom read (16 bytes read)
	[    4.406274] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
	[    4.425202] systemd[1]: Detected architecture arm.
	[    4.479869] systemd[1]: Set hostname to <bpi-m2z>.
	[    4.552434] random: systemd: uninitialized urandom read (16 bytes read)
	[    4.581781] random: systemd-gpt-aut: uninitialized urandom read (16 bytes read)
	[    4.603641] usb 1-1.2.3: new low-speed USB device number 4 using ehci-platform
	[    4.805497] usb 1-1.2.3: New USB device found, idVendor=1c4f, idProduct=0002, bcdDevice= 1.10
	[    4.815241] usb 1-1.2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
	[    4.823851] usb 1-1.2.3: Product: USB Keyboard
	[    4.828687] usb 1-1.2.3: Manufacturer: SIGMACHIP
	[    4.841926] input: SIGMACHIP USB Keyboard as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.0/0003:1C4F:0002.0001/input/input0
	[    4.940295] hid-generic 0003:1C4F:0002.0001: input,hidraw0: USB HID v1.10 Keyboard [SIGMACHIP USB Keyboard] on usb-1c1a000.usb-1.2.3/input0
	[    4.958249] input: SIGMACHIP USB Keyboard as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.3/1-1.2.3:1.1/0003:1C4F:0002.0002/input/input1
	[    5.041660] hid-generic 0003:1C4F:0002.0002: input,hidraw1: USB HID v1.10 Device [SIGMACHIP USB Keyboard] on usb-1c1a000.usb-1.2.3/input1
	[    5.145416] systemd[1]: Reached target Encrypted Volumes.
	[    5.163366] usb 1-1.2.4: new low-speed USB device number 5 using ehci-platform
	[    5.181715] systemd[1]: Created slice User and Session Slice.
	[    5.212408] systemd[1]: Listening on Journal Socket.
	[    5.241952] systemd[1]: Started Trigger resolvconf update for networkd DNS.
	[    5.271830] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
	[    5.301892] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
	[    5.326381] usb 1-1.2.4: New USB device found, idVendor=1bcf, idProduct=0007, bcdDevice= 0.10
	[    5.334958] usb 1-1.2.4: New USB device strings: Mfr=0, Product=2, SerialNumber=0
	[    5.342466] usb 1-1.2.4: Product: USB Optical Mouse
	[    5.342868] systemd[1]: Listening on fsck to fsckd communication Socket.
	[    5.382432] input: USB Optical Mouse as /devices/platform/soc/1c1a000.usb/usb1/1-1/1-1.2/1-1.2.4/1-1.2.4:1.0/0003:1BCF:0007.0003/input/input2
	[    5.395769] hid-generic 0003:1BCF:0007.0003: input,hiddev96,hidraw2: USB HID v1.10 Mouse [USB Optical Mouse] on usb-1c1a000.usb-1.2.4/input0
	[    5.587620] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
	[    5.698279] g_serial gadget: Gadget Serial v2.4
	[    5.702878] g_serial gadget: g_serial ready
	[    5.753973] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
	[    5.898336] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43430-sdio for chip BCM43430/1
	[    5.907193] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
	[    5.917396] brcmfmac mmc1:0001:1: Falling back to user helper
	[    7.326372] systemd-journald[172]: Received request to flush runtime journal from PID 1
	[    7.644637] cfg80211: failed to load regulatory.db
	[    7.797077] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-11), device may have limited channels available
	[    7.804024] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Mar 30 2016 11:30:56 version 7.45.77.h8.4 FWID 01-ee8a6268
	[    7.898630] mali: loading out-of-tree module taints kernel.
	[    7.909121] Allwinner sunXi mali glue initialized
	[    7.914554] Mali: 
	[    7.914580] Found Mali GPU Mali-400 MP r1p1
	[    7.927660] Registered IR keymap rc-empty
	[    7.927881] rc rc0: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0
	[    7.928081] input: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0/input3
	[    7.928562] rc rc0: lirc_dev: driver sunxi-ir registered at minor = 0
	[    7.933622] sunxi-ir 1f02000.ir: initialized sunXi IR driver
	[    7.937250] Mali: 
	[    7.937267] 2+0 PP cores initialized
	[    7.938660] Mali: 
	[    7.938669] Mali device driver loaded
	[    8.276382] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
	[    9.713723] Generic PHY 0.1:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0.1:01, irq=POLL)
	[    9.744264] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
	[    9.744286] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
	[    9.744955] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
	[    9.926737] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
	[   13.524321] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
	[   84.485105] random: crng init done
	[   84.485154] random: 7 urandom warning(s) missed due to ratelimiting

