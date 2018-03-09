# bananapi-zero-ubuntu-base-minimal
BananaPi M2 Zero  - Ubuntu Xenial Base Minimal Image (Experimental) - U-Boot 2017.09 / Kernel 4.15.y

This is a WiP, a bare minimum firmware image with basic configurations.
The idea behind this firmware is to have a very basic sd card image and add packages to your need.


Currently working, still need more tests

    * framebuffer with 1920x1080
    * eth up
    * wlan up
    * bare minimum image
    * reused nanopi rootfs

Known issues:
    
    * Hit ENTER to see the login prompt
    * Boot with your monitor/display turned ON

To do:

    * build regulatory.db to your country for the wifi
    * edit /etc/wpa_supplicant and add your SSID and password in order to use Wifi
    * rootfs for ubuntu 18.04
    * speed up boot times, i enabled verbosity to find errors
    * annotations on how to build
    * Clear instructions


# Basic instructions to flash firmware to SD CARD

* You need a linux box
* You need a SD CARD reader/writer

* insert your SD CARD into SDHC reader/writer:

  check which devide, type in shell: 

	dmesg | tail

 
	[47484.133274]  sdc: sdc1 sdc2
	[47488.681276] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
	[47488.955328] EXT4-fs (sdc2): mounted filesystem without journal. Opts: (null)


* format the sd card:

   in the example above, our sd card device is *sdc* (could be **sdb**)

	sudo ./format_sd_mainline.sh /dev/sdc

* flash Image to sd card:

	sudo ./flash_sdcard_m2z.sh /dev/sdc

* Booting first time
  
Before you boot, configure your wifi
	

# Connecting to AP via Wifi

Wifi use wpa_supplicant to connect to AP.
Before you boot the Image, please edit /etc/wpa_supplicant/wpa_supplicant.conf and add your data

	ctrl_interface=/var/run/wpa-supplicant
	ap_scan=1
	network={
	    ssid="YOUR SSID"
	    scan_ssid=1
	    key_mgmt=WPA-PSK
	    psk="YOUR_PLAIN_TEXT_PASSWORD"
	}




# bootlog of bpi-m2z with Kernel 4.15.7

    [    0.000000] Booting Linux on physical CPU 0x0
    [    0.000000] Linux version 4.15.7-h2-2 (alex@svn) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #1 SMP Sun Mar 4 13:00:48 -03 2018
    [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
    [    0.000000] CPU: div instructions available: patching division code
    [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
    [    0.000000] OF: fdt: Machine model: Banana Pi M2 Zero
    [    0.000000] Memory policy: Data cache writealloc
    [    0.000000] cma: Reserved 64 MiB at 0x59c00000
    [    0.000000] On node 0 totalpages: 131072
    [    0.000000]   Normal zone: 1024 pages used for memmap
    [    0.000000]   Normal zone: 0 pages reserved
    [    0.000000]   Normal zone: 131072 pages, LIFO batch:31
    [    0.000000] psci: probing for conduit method from DT.
    [    0.000000] psci: Using PSCI v0.1 Function IDs from DT
    [    0.000000] random: fast init done
    [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s34764 r8192 d22580 u65536
    [    0.000000] pcpu-alloc: s34764 r8192 d22580 u65536 alloc=16*4096
    [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
    [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
    [    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 rw rootwait fsck.repair=yes panic=10 hdmi.audio=EDID:0 disp.screen0_output_mode=1280x720p60 sunxi_ve_mem_reserve=0 sunxi_g2d_mem_reserve=0 sunxi_fb_mem_reserve=16
    [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
    [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
    [    0.000000] Memory: 441840K/524288K available (7168K kernel code, 425K rwdata, 1824K rodata, 1024K init, 278K bss, 16912K reserved, 65536K cma-reserved, 0K highmem)
    [    0.000000] Virtual kernel memory layout:
                       vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                       fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                       vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
                       lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
                       pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                       modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                         .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
                         .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
                         .data : 0x(ptrval) - 0x(ptrval)   ( 426 kB)
                          .bss : 0x(ptrval) - 0x(ptrval)   ( 279 kB)
    [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
    [    0.000000] Hierarchical RCU implementation.
    [    0.000000] 	RCU event tracing is enabled.
    [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
    [    0.000000] GIC: Using split EOI/Deactivate mode
    [    0.000000] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
    [    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
    [    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
    [    0.000007] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
    [    0.000019] Switching to timer-based delay loop, resolution 41ns
    [    0.000219] Console: colour dummy device 80x30
    [    0.000258] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
    [    0.000272] pid_max: default: 32768 minimum: 301
    [    0.000402] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
    [    0.000414] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
    [    0.001071] CPU: Testing write buffer coherency: ok
    [    0.001503] CPU0: update cpu_capacity 1024
    [    0.001515] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
    [    0.001870] Setting up static identity map for 0x40100000 - 0x40100060
    [    0.001983] Hierarchical SRCU implementation.
    [    0.002629] smp: Bringing up secondary CPUs ...
    [    0.013307] CPU1: update cpu_capacity 1024
    [    0.013314] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
    [    0.024056] CPU2: update cpu_capacity 1024
    [    0.024062] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
    [    0.034756] CPU3: update cpu_capacity 1024
    [    0.034761] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
    [    0.034838] smp: Brought up 1 node, 4 CPUs
    [    0.034865] SMP: Total of 4 processors activated (192.00 BogoMIPS).
    [    0.034871] CPU: All CPU(s) started in HYP mode.
    [    0.034875] CPU: Virtualization extensions available.
    [    0.035817] devtmpfs: initialized
    [    0.040889] VFP support v0.3: implementor 41 architecture 2 part 30 variant 7 rev 5
    [    0.041123] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
    [    0.041147] futex hash table entries: 1024 (order: 4, 65536 bytes)
    [    0.043656] pinctrl core: initialized pinctrl subsystem
    [    0.044765] NET: Registered protocol family 16
    [    0.046539] DMA: preallocated 256 KiB pool for atomic coherent allocations
    [    0.047305] cpuidle: using governor ladder
    [    0.047334] cpuidle: using governor menu
    [    0.047733] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
    [    0.047743] hw-breakpoint: maximum watchpoint size is 8 bytes.
    [    0.061863] SCSI subsystem initialized
    [    0.062108] libata version 3.00 loaded.
    [    0.062293] usbcore: registered new interface driver usbfs
    [    0.062338] usbcore: registered new interface driver hub
    [    0.062393] usbcore: registered new device driver usb
    [    0.062649] pps_core: LinuxPPS API ver. 1 registered
    [    0.062656] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
    [    0.062675] PTP clock support registered
    [    0.062837] Advanced Linux Sound Architecture Driver Initialized.
    [    0.064073] clocksource: Switched to clocksource arch_sys_counter
    [    0.064208] VFS: Disk quotas dquot_6.6.0
    [    0.064274] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
    [    0.071030] NET: Registered protocol family 2
    [    0.071642] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
    [    0.071699] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
    [    0.071761] TCP: Hash tables configured (established 4096 bind 4096)
    [    0.071884] UDP hash table entries: 256 (order: 1, 8192 bytes)
    [    0.071930] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
    [    0.072162] NET: Registered protocol family 1
    [    0.072571] RPC: Registered named UNIX socket transport module.
    [    0.072581] RPC: Registered udp transport module.
    [    0.072587] RPC: Registered tcp transport module.
    [    0.072592] RPC: Registered tcp NFSv4.1 backchannel transport module.
    [    0.073257] Unpacking initramfs...
    [    0.116529] Freeing initrd memory: 960K
    [    0.118230] Initialise system trusted keyrings
    [    0.118521] workingset: timestamp_bits=30 max_order=17 bucket_order=0
    [    0.123741] NFS: Registering the id_resolver key type
    [    0.123780] Key type id_resolver registered
    [    0.123787] Key type id_legacy registered
    [    0.123802] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
    [    0.123810] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
    [    0.124694] fuse init (API version 7.26)
    [    0.128809] Key type asymmetric registered
    [    0.128825] Asymmetric key parser 'x509' registered
    [    0.128910] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
    [    0.128921] io scheduler noop registered
    [    0.128929] io scheduler deadline registered
    [    0.129064] io scheduler cfq registered (default)
    [    0.129074] io scheduler mq-deadline registered
    [    0.129081] io scheduler kyber registered
    [    0.129840] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
    [    0.133249] sun8i-h3-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
    [    0.134832] sun8i-h3-r-pinctrl 1f02c00.pinctrl: initialized sunXi PIO driver
    [    0.179774] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
    [    0.182137] console [ttyS0] disabled
    [    0.202329] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 44, base_baud = 1500000) is a U6_16550A
    [    0.885067] console [ttyS0] enabled
    [    0.909622] 1c28400.serial: ttyS1 at MMIO 0x1c28400 (irq = 45, base_baud = 1500000) is a U6_16550A
    [    0.930347] sun4i-drm display-engine: bound 1100000.mixer (ops 0xc0855038)
    [    0.937278] sun4i-tcon 1c0c000.lcd-controller: Missing LVDS properties, Please upgrade your DT
    [    0.945888] sun4i-tcon 1c0c000.lcd-controller: LVDS output disabled
    [    0.952368] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
    [    0.960216] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xc0852f78)
    [    0.968706] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
    [    0.978583] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
    [    0.986327] sun4i-drm display-engine: bound 1ee0000.hdmi (ops 0xc0854b98)
    [    0.993111] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
    [    0.999736] [drm] No driver support for vblank timestamp query.
    [    1.511373] Console: switching to colour frame buffer device 240x67
    [    1.550983] sun4i-drm display-engine: fb0:  frame buffer device
    [    1.557291] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
    [    1.567423] libphy: Fixed MDIO Bus: probed
    [    1.571650] CAN device driver interface
    [    1.576083] dwmac-sun8i 1c30000.ethernet: PTP uses main clock
    [    1.581864] dwmac-sun8i 1c30000.ethernet: No regulator found
    [    1.587644] dwmac-sun8i 1c30000.ethernet: Chain mode enabled
    [    1.593300] dwmac-sun8i 1c30000.ethernet: No HW DMA feature register supported
    [    1.600535] dwmac-sun8i 1c30000.ethernet: Normal descriptors
    [    1.606198] dwmac-sun8i 1c30000.ethernet: RX Checksum Offload Engine supported
    [    1.613410] dwmac-sun8i 1c30000.ethernet: COE Type 2
    [    1.618381] dwmac-sun8i 1c30000.ethernet: TX Checksum insertion supported
    [    1.625281] libphy: stmmac: probed
    [    1.629129] dwmac-sun8i 1c30000.ethernet: Found internal PHY node
    [    1.635343] libphy: mdio_mux: probed
    [    1.638931] dwmac-sun8i 1c30000.ethernet: Switch mux to internal PHY
    [    1.645293] dwmac-sun8i 1c30000.ethernet: Powering internal PHY
    [    1.652183] libphy: mdio_mux: probed
    [    1.656149] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
    [    1.662668] ehci-platform: EHCI generic platform driver
    [    1.668102] ehci-platform 1c1a000.usb: EHCI Host Controller
    [    1.673694] ehci-platform 1c1a000.usb: new USB bus registered, assigned bus number 1
    [    1.681893] ehci-platform 1c1a000.usb: irq 28, io mem 0x01c1a000
    [    1.714077] ehci-platform 1c1a000.usb: USB 2.0 started, EHCI 1.00
    [    1.720387] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
    [    1.727187] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    1.734409] usb usb1: Product: EHCI Host Controller
    [    1.739289] usb usb1: Manufacturer: Linux 4.15.7-h2-2 ehci_hcd
    [    1.745124] usb usb1: SerialNumber: 1c1a000.usb
    [    1.750190] hub 1-0:1.0: USB hub found
    [    1.753986] hub 1-0:1.0: 1 port detected
    [    1.758595] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
    [    1.764809] ohci-platform: OHCI generic platform driver
    [    1.770239] ohci-platform 1c1a400.usb: Generic Platform OHCI controller
    [    1.776881] ohci-platform 1c1a400.usb: new USB bus registered, assigned bus number 2
    [    1.784852] ohci-platform 1c1a400.usb: irq 29, io mem 0x01c1a400
    [    1.858256] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
    [    1.865064] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    1.872285] usb usb2: Product: Generic Platform OHCI controller
    [    1.878211] usb usb2: Manufacturer: Linux 4.15.7-h2-2 ohci_hcd
    [    1.884037] usb usb2: SerialNumber: 1c1a400.usb
    [    1.889077] hub 2-0:1.0: USB hub found
    [    1.892858] hub 2-0:1.0: 1 port detected
    [    1.897514] usbcore: registered new interface driver cdc_acm
    [    1.903168] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
    [    1.911249] usbcore: registered new interface driver usblp
    [    1.916785] usbcore: registered new interface driver cdc_wdm
    [    1.922502] usbcore: registered new interface driver usb-storage
    [    1.928599] usbcore: registered new interface driver ch341
    [    1.934126] usbserial: USB Serial support registered for ch341-uart
    [    1.940413] usbcore: registered new interface driver cp210x
    [    1.946013] usbserial: USB Serial support registered for cp210x
    [    1.951976] usbcore: registered new interface driver ftdi_sio
    [    1.957753] usbserial: USB Serial support registered for FTDI USB Serial Device
    [    1.965174] usbcore: registered new interface driver pl2303
    [    1.970762] usbserial: USB Serial support registered for pl2303
    [    1.977410] mousedev: PS/2 mouse device common for all mice
    [    1.983640] sun6i-rtc 1f00000.rtc: rtc core: registered rtc-sun6i as rtc0
    [    1.990457] sun6i-rtc 1f00000.rtc: RTC enabled
    [    1.995103] i2c /dev entries driver
    [    1.999926] thermal thermal_zone0: failed to read out thermal zone (-16)
    [    2.007341] sunxi-wdt 1c20ca0.watchdog: Watchdog enabled (timeout=16 sec, nowayout=0)
    [    2.074095] sunxi-mmc 1c0f000.mmc: base:0x480d4461 irq:25
    [    2.080373] sunxi-mmc 1c10000.mmc: allocated mmc-pwrseq
    [    2.131043] mmc0: host does not support reading read-only switch, assuming write-enable
    [    2.140974] mmc0: new high speed SDHC card at address 59b4
    [    2.146795] sunxi-mmc 1c10000.mmc: base:0xdc516d28 irq:26
    [    2.153160] mmcblk0: mmc0:59b4 SDU1  7.52 GiB 
    [    2.158039] ledtrig-cpu: registered to indicate activity on CPUs
    [    2.164287] hidraw: raw HID events driver (C) Jiri Kosina
    [    2.170085] usbcore: registered new interface driver usbhid
    [    2.175681] usbhid: USB HID core driver
    [    2.182402] sun4i-codec 1c22c00.codec: ASoC: codec-analog@1f015c0 not registered
    [    2.189854] sun4i-codec 1c22c00.codec: Failed to register our card
    [    2.198263]  mmcblk0: p1 p2
    [    2.203159] Initializing XFRM netlink socket
    [    2.207489] NET: Registered protocol family 17
    [    2.211957] can: controller area network core (rev 20170425 abi 9)
    [    2.218243] NET: Registered protocol family 29
    [    2.222684] can: raw protocol (rev 20170425)
    [    2.226962] can: broadcast manager protocol (rev 20170425 t)
    [    2.232620] can: netlink gateway (rev 20170425) max_hops=1
    [    2.238424] 9pnet: Installing 9P2000 support
    [    2.242726] Key type dns_resolver registered
    [    2.247303] Registering SWP/SWPB emulation handler
    [    2.252645] Loading compiled-in X.509 certificates
    [    2.264613] ehci-platform 1c1b000.usb: EHCI Host Controller
    [    2.270221] ehci-platform 1c1b000.usb: new USB bus registered, assigned bus number 3
    [    2.278633] ehci-platform 1c1b000.usb: irq 30, io mem 0x01c1b000
    [    2.291874] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
    [    2.298869] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
    [    2.305857] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
    [    2.314023] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
    [    2.319533] ehci-platform 1c1b000.usb: USB 2.0 started, EHCI 1.00
    [    2.325850] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
    [    2.332632] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.339857] usb usb3: Product: EHCI Host Controller
    [    2.344742] usb usb3: Manufacturer: Linux 4.15.7-h2-2 ehci_hcd
    [    2.350567] usb usb3: SerialNumber: 1c1b000.usb
    [    2.355699] hub 3-0:1.0: USB hub found
    [    2.359489] hub 3-0:1.0: 1 port detected
    [    2.364221] ehci-platform 1c1c000.usb: EHCI Host Controller
    [    2.369814] ehci-platform 1c1c000.usb: new USB bus registered, assigned bus number 4
    [    2.377888] ehci-platform 1c1c000.usb: irq 32, io mem 0x01c1c000
    [    2.385729] mmc1: queuing unknown CIS tuple 0x81 (9 bytes)
    [    2.404070] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI 1.00
    [    2.410344] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
    [    2.417154] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.424383] usb usb4: Product: EHCI Host Controller
    [    2.429246] usb usb4: Manufacturer: Linux 4.15.7-h2-2 ehci_hcd
    [    2.435084] usb usb4: SerialNumber: 1c1c000.usb
    [    2.440088] hub 4-0:1.0: USB hub found
    [    2.443871] hub 4-0:1.0: 1 port detected
    [    2.448490] ehci-platform 1c1d000.usb: EHCI Host Controller
    [    2.454100] ehci-platform 1c1d000.usb: new USB bus registered, assigned bus number 5
    [    2.462127] ehci-platform 1c1d000.usb: irq 34, io mem 0x01c1d000
    [    2.494074] ehci-platform 1c1d000.usb: USB 2.0 started, EHCI 1.00
    [    2.500356] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002
    [    2.507162] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.514389] usb usb5: Product: EHCI Host Controller
    [    2.519261] usb usb5: Manufacturer: Linux 4.15.7-h2-2 ehci_hcd
    [    2.525098] usb usb5: SerialNumber: 1c1d000.usb
    [    2.530082] hub 5-0:1.0: USB hub found
    [    2.533874] hub 5-0:1.0: 1 port detected
    [    2.538472] ohci-platform 1c1b400.usb: Generic Platform OHCI controller
    [    2.545119] ohci-platform 1c1b400.usb: new USB bus registered, assigned bus number 6
    [    2.553092] ohci-platform 1c1b400.usb: irq 31, io mem 0x01c1b400
    [    2.601678] mmc1: new high speed SDIO card at address 0001
    [    2.628250] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
    [    2.635048] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.642261] usb usb6: Product: Generic Platform OHCI controller
    [    2.648186] usb usb6: Manufacturer: Linux 4.15.7-h2-2 ohci_hcd
    [    2.654010] usb usb6: SerialNumber: 1c1b400.usb
    [    2.659378] hub 6-0:1.0: USB hub found
    [    2.663155] hub 6-0:1.0: 1 port detected
    [    2.667775] ohci-platform 1c1c400.usb: Generic Platform OHCI controller
    [    2.674426] ohci-platform 1c1c400.usb: new USB bus registered, assigned bus number 7
    [    2.682446] ohci-platform 1c1c400.usb: irq 33, io mem 0x01c1c400
    [    2.758254] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
    [    2.765052] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.772265] usb usb7: Product: Generic Platform OHCI controller
    [    2.778203] usb usb7: Manufacturer: Linux 4.15.7-h2-2 ohci_hcd
    [    2.784031] usb usb7: SerialNumber: 1c1c400.usb
    [    2.789108] hub 7-0:1.0: USB hub found
    [    2.792894] hub 7-0:1.0: 1 port detected
    [    2.797604] ohci-platform 1c1d400.usb: Generic Platform OHCI controller
    [    2.804264] ohci-platform 1c1d400.usb: new USB bus registered, assigned bus number 8
    [    2.812294] ohci-platform 1c1d400.usb: irq 35, io mem 0x01c1d400
    [    2.888258] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001
    [    2.895059] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.902271] usb usb8: Product: Generic Platform OHCI controller
    [    2.908193] usb usb8: Manufacturer: Linux 4.15.7-h2-2 ohci_hcd
    [    2.914018] usb usb8: SerialNumber: 1c1d400.usb
    [    2.919018] hub 8-0:1.0: USB hub found
    [    2.922795] hub 8-0:1.0: 1 port detected
    [    2.927439] usb_phy_generic usb_phy_generic.3.auto: usb_phy_generic.3.auto supply vcc not found, using dummy regulator
    [    2.938575] musb-hdrc musb-hdrc.4.auto: MUSB HDRC host driver
    [    2.944351] musb-hdrc musb-hdrc.4.auto: new USB bus registered, assigned bus number 9
    [    2.952369] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002
    [    2.959167] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
    [    2.966394] usb usb9: Product: MUSB HDRC host driver
    [    2.971354] usb usb9: Manufacturer: Linux 4.15.7-h2-2 musb-hcd
    [    2.977191] usb usb9: SerialNumber: musb-hdrc.4.auto
    [    2.982571] hub 9-0:1.0: USB hub found
    [    2.986364] hub 9-0:1.0: 1 port detected
    [    2.994917] sun4i-codec 1c22c00.codec: Codec <-> 1c22c00.codec mapping ok
    [    3.002824] sun6i-rtc 1f00000.rtc: setting system clock to 1970-01-01 00:13:05 UTC (785)
    [    3.011131] cfg80211: Loading compiled-in X.509 certificates for regulatory database
    [    3.021541] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
    [    3.028233] vcc3v0: disabling
    [    3.031202] vcc5v0: disabling
    [    3.034196] ALSA device list:
    [    3.037160]   #0: H3 Audio Codec
    [    3.040959] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
    [    3.049502] platform regulatory.0: Falling back to user helper
    [    3.051346] Freeing unused kernel memory: 1024K
    [    3.183575] EXT4-fs (mmcblk0p2): couldn't mount as ext3 due to feature incompatibilities
    [    3.194491] EXT4-fs (mmcblk0p2): couldn't mount as ext2 due to feature incompatibilities
    [    3.225986] EXT4-fs (mmcblk0p2): mounted filesystem without journal. Opts: (null)
    [    3.464264] usb 1-1: new high-speed USB device number 2 using ehci-platform
    [    3.666140] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608
    [    3.672989] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
    [    3.680261] usb 1-1: Product: USB2.0 Hub
    [    3.686584] hub 1-1:1.0: USB hub found
    [    3.690674] hub 1-1:1.0: 4 ports detected
    [    3.812036] systemd[1]: System time before build time, advancing clock.
    [    3.948993] NET: Registered protocol family 10
    [    4.000166] Segment Routing with IPv6
    [    4.071215] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
    [    4.090052] systemd[1]: Detected architecture arm.
    [    4.127272] systemd[1]: Set hostname to <bpi-m2z>.
    [    4.534538] systemd[1]: Listening on Journal Socket (/dev/log).
    [    4.568257] systemd[1]: Listening on fsck to fsckd communication Socket.
    [    4.604269] systemd[1]: Reached target Swap.
    [    4.637204] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
    [    4.674276] systemd[1]: Reached target Encrypted Volumes.
    [    4.707831] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
    [    4.744665] systemd[1]: Listening on Journal Socket.
    [    5.102989] g_serial gadget: Gadget Serial v2.4
    [    5.107569] g_serial gadget: g_serial ready
    [    5.181364] brcmfmac: brcmf_fw_map_chip_to_name: using brcm/brcmfmac43430-sdio.bin for chip 0x00a9a6(43430) rev 0x000001
    [    5.246956] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
    [    5.322820] brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43430-sdio.clm_blob failed with error -2
    [    5.333077] brcmfmac mmc1:0001:1: Falling back to user helper
    [    6.157353] systemd-journald[151]: Received request to flush runtime journal from PID 1
    [    6.419020] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available(err=-11), device may have limited channels available
    [    6.423564] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Mar 30 2016 11:30:56 version 7.45.77.h8.4 FWID 01-ee8a6268
    [    6.571659] cfg80211: failed to load regulatory.db
    [    6.808257] lirc_dev: IR Remote Control driver registered, major 244
    [    6.841194] IR LIRC bridge handler initialized
    [    6.842174] Registered IR keymap rc-empty
    [    6.842393] rc rc0: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0
    [    6.842573] input: sunxi-ir as /devices/platform/soc/1f02000.ir/rc/rc0/input0
    [    6.843782] lirc lirc0: lirc_dev: driver ir-lirc-codec (sunxi-ir) registered at minor = 0
    [    6.843985] sunxi-ir 1f02000.ir: initialized sunXi IR driver
    [    7.922410] EXT4-fs (mmcblk0p1): mounted filesystem with ordered data mode. Opts: (null)
    [    8.415538] Generic PHY 0.1:01: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0.1:01, irq=POLL)
    [    8.418737] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
    [    8.418761] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
    [    8.419198] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
    [    8.473442] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
    [    8.514966] random: crng init done

