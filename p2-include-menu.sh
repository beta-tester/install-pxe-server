#!/bin/bash

########################################################################
if [[ -z "$script_dir" ]]
then
    echo "do not run this script directly !"
    echo "this script is part of p2-update.sh"
    exit -1
fi
########################################################################

if ! [[ "$1" == "ipxe" ]]
then
########################################################################
## lpxelinux

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$ARCH_NETBOOT_X64/kernel" ]]; then
    echo  -e "\e[36m    add $ARCH_NETBOOT_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    # INFO: https://www.archlinux.org/releng/netboot/
    LABEL $ARCH_NETBOOT_X64
        MENU LABEL Arch netboot x64
    #    KERNEL https://www.archlinux.org/static/netboot/ipxe.lkrn
        KERNEL $FILE_BASE$NFS_ETH0/$ARCH_NETBOOT_X64/kernel
        TEXT HELP
            Boot to Arch netboot x64
            User: root
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$BLACKARCH_X64/blackarch/boot/x86_64/vmlinuz-linux" ]]; then
    echo  -e "\e[36m    add $BLACKARCH_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $BLACKARCH_X64
        MENU LABEL BlackArch x64
        KERNEL $FILE_BASE$NFS_ETH0/$BLACKARCH_X64/blackarch/boot/x86_64/vmlinuz-linux
        INITRD $FILE_BASE$NFS_ETH0/$BLACKARCH_X64/blackarch/boot/intel-ucode.img,$FILE_BASE$NFS_ETH0/$BLACKARCH_X64/blackarch/boot/amd-ucode.img,$FILE_BASE$NFS_ETH0/$BLACKARCH_X64/blackarch/boot/x86_64/initramfs-linux.img
        APPEND ip=dhcp ro archisobasedir=blackarch archiso_nfs_srv=$IP_ETH0:$DST_NFS_ETH0/$BLACKARCH_X64 copytoram=n
        #SYSAPPEND 3
        TEXT HELP
            Boot to BlackArch Linux full medium (x86_64, UEFI)
            User:  root, Password: blackarch
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$CLONEZILLA_X64/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $CLONEZILLA_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $CLONEZILLA_X64
        MENU LABEL Clonezilla x64
        KERNEL $FILE_BASE$NFS_ETH0/$CLONEZILLA_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$CLONEZILLA_X64/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$CLONEZILLA_X64 ro netboot=nfs boot=live config username=user hostname=clonezilla union=overlay components noswap edd=on nomodeset nodmraid ocs_live_run=ocs-live-general ocs_live_extra_param= ocs_live_batch=no net.ifnames=0 nosplash noprompt -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Clonezilla x64
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$CLONEZILLA_X86/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $CLONEZILLA_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $CLONEZILLA_X86
        MENU LABEL Clonezilla x86
        KERNEL $FILE_BASE$NFS_ETH0/$CLONEZILLA_X86/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$CLONEZILLA_X86/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$CLONEZILLA_X86 ro netboot=nfs boot=live config username=user hostname=clonezilla union=overlay components noswap edd=on nomodeset nodmraid ocs_live_run=ocs-live-general ocs_live_extra_param= ocs_live_batch=no net.ifnames=0 nosplash noprompt -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Clonezilla x86
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEBIAN_TESTING_X64/live/vmlinuz-$DEBIAN_TESTING_KVER-amd64" ]]; then
    echo  -e "\e[36m    add $DEBIAN_TESTING_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEBIAN_TESTING_X64
        MENU LABEL Debian x64 (testing)
        KERNEL $FILE_BASE$NFS_ETH0/$DEBIAN_TESTING_X64/live/vmlinuz-$DEBIAN_TESTING_KVER-amd64
        INITRD $FILE_BASE$NFS_ETH0/$DEBIAN_TESTING_X64/live/initrd.img-$DEBIAN_TESTING_KVER-amd64
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEBIAN_TESTING_X64 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Debian x64 Live (testing)
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEBIAN_X64/live/vmlinuz-$DEBIAN_KVER-amd64" ]]; then
    echo  -e "\e[36m    add $DEBIAN_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEBIAN_X64
        MENU LABEL Debian x64
        KERNEL $FILE_BASE$NFS_ETH0/$DEBIAN_X64/live/vmlinuz-$DEBIAN_KVER-amd64
        INITRD $FILE_BASE$NFS_ETH0/$DEBIAN_X64/live/initrd.img-$DEBIAN_KVER-amd64
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEBIAN_X64 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Debian x64 Live LXDE
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEBIAN_X86/live/vmlinuz-$DEBIAN_KVER-686" ]]; then
    echo  -e "\e[36m    add $DEBIAN_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEBIAN_X86
        MENU LABEL Debian x86
        KERNEL $FILE_BASE$NFS_ETH0/$DEBIAN_X86/live/vmlinuz-$DEBIAN_KVER-686
        INITRD $FILE_BASE$NFS_ETH0/$DEBIAN_X86/live/initrd.img-$DEBIAN_KVER-686
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEBIAN_X86 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Debian x86 Live LXDE
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEFT_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DEFT_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEFT_X64
        MENU LABEL DEFT x64
        KERNEL $FILE_BASE$NFS_ETH0/$DEFT_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DEFT_X64/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEFT_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper memtest=4 -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to DEFT x64 Live
            User: root, Password: toor
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEFTZ_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DEFTZ_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEFTZ_X64
        MENU LABEL DEFT Zero x64
        KERNEL $FILE_BASE$NFS_ETH0/$DEFTZ_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DEFTZ_X64/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEFTZ_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper memtest=4 -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to DEFT Zero x64 Live
            User: root, Password: toor
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEVUAN_X64/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DEVUAN_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEVUAN_X64
        MENU LABEL Devuan x64
        KERNEL $FILE_BASE$NFS_ETH0/$DEVUAN_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DEVUAN_X64/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEVUAN_X64 ro netboot=nfs boot=live username=devuan config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Devuan x64 Live
            User: devuan
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DEVUAN_X86/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DEVUAN_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DEVUAN_X86
        MENU LABEL Devuan x86
        KERNEL $FILE_BASE$NFS_ETH0/$DEVUAN_X86/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DEVUAN_X86/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DEVUAN_X86 ro netboot=nfs boot=live username=devuan config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Devuan x86 Live
            User: devuan
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DRAGONOS_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DRAGONOS_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DRAGONOS_X64
        MENU LABEL DragonOS x64
        KERNEL $FILE_BASE$NFS_ETH0/$DRAGONOS_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DRAGONOS_X64/casper/initrd.gz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DRAGONOS_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to DragonOS x64 Live
            User: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$ESET_SYSRESCUE_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $ESET_SYSRESCUE_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $ESET_SYSRESCUE_X86
        MENU LABEL ESET SysRescue Live
        KERNEL $FILE_BASE$NFS_ETH0/$ESET_SYSRESCUE_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$ESET_SYSRESCUE_X86/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$ESET_SYSRESCUE_X86 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to ESET SysRescue Live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$FEDORA_X64/isolinux/vmlinuz" ]]; then
    echo  -e "\e[36m    add $FEDORA_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## INFO: http://people.redhat.com/harald/dracut.html#dracut.kernel
    ##       https://github.com/haraldh/dracut/blob/master/dracut.cmdline.7.asc
    ##       https://lukas.zapletalovi.com/2016/08/hidden-feature-of-fedora-24-live-pxe-boot.html
    LABEL $FEDORA_X64
        MENU LABEL Fedora x64
        KERNEL $FILE_BASE$NFS_ETH0/$FEDORA_X64/isolinux/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$FEDORA_X64/isolinux/initrd.img
        APPEND ip=dhcp root=live:nfs://$IP_ETH0$DST_NFS_ETH0/$FEDORA_X64/LiveOS/squashfs.img ro rd.live.image rd.lvm=0 rd.luks=0 rd.md=0 rd.dm=0 vga=794 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE
        TEXT HELP
            Boot to Fedora Workstation Live
            User: liveuser
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$GNURADIO_X64/casper/vmlinuz.efi" ]]; then
    echo  -e "\e[36m    add $GNURADIO_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $GNURADIO_X64
        MENU LABEL GNU Radio x64
        KERNEL $FILE_BASE$NFS_ETH0/$GNURADIO_X64/casper/vmlinuz.efi
        INITRD $FILE_BASE$NFS_ETH0/$GNURADIO_X64/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$GNURADIO_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to GNU Radio x64 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$KALI_X64/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $KALI_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $KALI_X64
        MENU LABEL Kali x64
        KERNEL $FILE_BASE$NFS_ETH0/$KALI_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$KALI_X64/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$KALI_X64 ro netboot=nfs boot=live noconfig=sudo username=kali hostname=kali -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Kali x64 Live
            User: kali, Password: kali
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$KASPERSKY_RESCUE_X86/boot/grub/k-x86_64" ]]; then
    echo  -e "\e[36m    add $KASPERSKY_RESCUE_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $KASPERSKY_RESCUE_X86
        MENU LABEL Kaspersky Rescue Disk
        KERNEL $FILE_BASE$NFS_ETH0/$KASPERSKY_RESCUE_X86/boot/grub/k-x86
        INITRD $FILE_BASE$NFS_ETH0/$KASPERSKY_RESCUE_X86/boot/grub/initrd.xz
        APPEND ip=dhcp netboot=nfs://$IP_ETH0:$DST_NFS_ETH0/$KASPERSKY_RESCUE_X86 ro dostartx -- lang=us setkmap=us
        TEXT HELP
            Boot to Kaspersky Rescue Disk
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$KNOPPIX_X86/boot/isolinux/linux" ]]; then
    if ! [[ -f "$DST_NFS_ETH0/$KNOPPIX_X86-miniroot-8.6.1.gz" ]]; then
        echo  -e "\e[36m    download patch for $KNOPPIX_X86\e[0m";
        sudo wget --quiet -O $DST_NFS_ETH0/$KNOPPIX_X86-miniroot-8.6.1.gz https://github.com/beta-tester/RPi-PXE-Server/files/3932135/$KNOPPIX_X86-miniroot-8.6.1.gz
    fi
    if [[ -f "$DST_NFS_ETH0/$KNOPPIX_X86-miniroot-8.6.1.gz" ]]; then
        echo  -e "\e[36m    add $KNOPPIX_X86\e[0m";
        cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## INFO: https://github.com/beta-tester/RPi-PXE-Server/issues/27
    ## $ knoppix-terminalserver
    ## $ cp /tmp/tftproot/miniroot.gz  /srv/nfs/knoppix-x86-miniroot.gz
    LABEL $KNOPPIX_X86
        MENU LABEL Knoppix x86
        KERNEL $FILE_BASE$NFS_ETH0/$KNOPPIX_X86/boot/isolinux/linux
        INITRD $FILE_BASE$NFS_ETH0/knoppix-x86-miniroot-8.6.1.gz
        APPEND ip=dhcp nfsdir=$IP_ETH0:$DST_NFS_ETH0/$KNOPPIX_X86 nodhcp ramdisk_size=100000 init=/sbin/init apm=power-off nomce loglevel=1 libata.force=noncq tz=localtime hpsa.hpsa_allow_any=1 BOOT_IMAGE=knoppix -- lang=de
        TEXT HELP
            Boot to Knoppix x86 Live
        ENDTEXT
EOF
    else
        echo  -e "\e[1;31m    failed $KNOPPIX_X86,\e[0m"
        echo  -e "\e[1;31m        please visit: https://github.com/beta-tester/RPi-PXE-Server/issues/27\e[0m";
    fi
fi
#========== END ==========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$LUBUNTU_DAILY_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $LUBUNTU_DAILY_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $LUBUNTU_DAILY_X64
        MENU LABEL lubuntu x64 Daily-Live
        KERNEL $FILE_BASE$NFS_ETH0/$LUBUNTU_DAILY_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$LUBUNTU_DAILY_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$LUBUNTU_DAILY_X64 ro netboot=nfs file=/cdrom/preseed/lubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to lubuntu x64 Daily-Live
            User: lubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$LUBUNTU_LTS_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $LUBUNTU_LTS_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $LUBUNTU_LTS_X64
        MENU LABEL lubuntu LTS x64
        KERNEL $FILE_BASE$NFS_ETH0/$LUBUNTU_LTS_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$LUBUNTU_LTS_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$LUBUNTU_LTS_X64 ro netboot=nfs file=/cdrom/preseed/lubuntu.seed boot=casper systemd.mask=tmp.mount -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to lubuntu LTS x64 Live
            User: lubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$LUBUNTU_LTS_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $LUBUNTU_LTS_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $LUBUNTU_LTS_X86
        MENU LABEL lubuntu LTS x86
        KERNEL $FILE_BASE$NFS_ETH0/$LUBUNTU_LTS_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$LUBUNTU_LTS_X86/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$LUBUNTU_LTS_X86 ro netboot=nfs file=/cdrom/preseed/lubuntu.seed boot=casper systemd.mask=tmp.mount -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to lubuntu LTS x86 Live
            User: lubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$LUBUNTU_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $LUBUNTU_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $LUBUNTU_X64
        MENU LABEL lubuntu x64
        KERNEL $FILE_BASE$NFS_ETH0/$LUBUNTU_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$LUBUNTU_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$LUBUNTU_X64 ro netboot=nfs file=/cdrom/preseed/lubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to lubuntu x64 Live
            User: lubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$LUBUNTU_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $LUBUNTU_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $LUBUNTU_X86
        MENU LABEL lubuntu x86
        KERNEL $FILE_BASE$NFS_ETH0/$LUBUNTU_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$LUBUNTU_X86/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$LUBUNTU_X86 ro netboot=nfs file=/cdrom/preseed/lubuntu.seed boot=casper systemd.mask=tmp.mount -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to lubuntu x86 Live
            User: lubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$MINT_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $MINT_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $MINT_X64
        MENU LABEL linux-mint x64
        KERNEL $FILE_BASE$NFS_ETH0/$MINT_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$MINT_X64/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$MINT_X64 ro netboot=nfs file=/cdrom/preseed/linuxmint.seed boot=casper systemd.mask=tmp.mount -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to linux-mint x64 Live
            User:
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$OPENSUSE_RESCUE_X64/boot/x86_64/loader/linux" ]]; then
    echo  -e "\e[36m    add $OPENSUSE_RESCUE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $OPENSUSE_RESCUE_X64
        MENU LABEL openSUSE Leap Rescue x64
        KERNEL $FILE_BASE$NFS_ETH0/$OPENSUSE_RESCUE_X64/boot/x86_64/loader/linux
        INITRD $FILE_BASE$NFS_ETH0/$OPENSUSE_RESCUE_X64/boot/x86_64/loader/initrd
        APPEND ip=dhcp root=live:AOEINTERFACE=e0.1 rd.kiwi.live.pxe --
        TEXT HELP
            Boot to openSUSE Leap Rescue Live
            User: liveuser
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$OPENSUSE_X64/boot/x86_64/loader/linux" ]]; then
    echo  -e "\e[36m    add $OPENSUSE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $OPENSUSE_X64
        MENU LABEL openSUSE Leap x64
        KERNEL $FILE_BASE$NFS_ETH0/$OPENSUSE_X64/boot/x86_64/loader/linux
        INITRD $FILE_BASE$NFS_ETH0/$OPENSUSE_X64/boot/x86_64/loader/initrd
        APPEND ip=dhcp root=live:AOEINTERFACE=e1.1 rd.kiwi.live.pxe --
        TEXT HELP
            Boot to openSUSE Leap Live
            User: liveuser
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$PARROT_FULL_X64/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $PARROT_FULL_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $PARROT_FULL_X64
        MENU LABEL Parrot Full x64
        KERNEL $FILE_BASE$NFS_ETH0/$PARROT_FULL_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$PARROT_FULL_X64/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$PARROT_FULL_X64 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE pkeys=$CUSTOM_KMAP setxkbmap=$CUSTOM_KMAP utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Parrot Full x64 Live (Security)
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$PARROT_LITE_X64/live/vmlinuz" ]]; then
    echo  -e "\e[36m    add $PARROT_LITE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $PARROT_LITE_X64
        MENU LABEL Parrot Lite x64
        KERNEL $FILE_BASE$NFS_ETH0/$PARROT_LITE_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$PARROT_LITE_X64/live/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$PARROT_LITE_X64 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE pkeys=$CUSTOM_KMAP setxkbmap=$CUSTOM_KMAP utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Parrot Lite x64 Live (Home/Workstation)
            User: user, Password: live
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$PENTOO_BETA_X64/boot/pentoo" ]]; then
    echo  -e "\e[36m    add $PENTOO_BETA_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $PENTOO_BETA_X64
        MENU LABEL Pentoo Beta x64
        KERNEL $FILE_BASE$NFS_ETH0/$PENTOO_BETA_X64/boot/pentoo
        INITRD $FILE_BASE$NFS_ETH0/$PENTOO_BETA_X64/boot/pentoo.igz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$PENTOO_BETA_X64 ro real_root=/dev/nfs root=/dev/ram0 init=/linuxrc overlayfs looptype=squashfs loop=/image.squashfs cdroot nox secureconsole max_loop=256 dokeymap video=uvesafb:mtrr:3,ywrap,1024x768-16 console=tty0 scsi_mod.use_blk_mq=1 net.ifnames=0 ipv6.autoconf=0 --
        TEXT HELP
            Boot to Pentoo Beta x64 Live
            User: pentoo
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$PENTOO_X64/boot/pentoo" ]]; then
    echo  -e "\e[36m    add $PENTOO_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $PENTOO_X64
        MENU LABEL Pentoo x64
        KERNEL $FILE_BASE$NFS_ETH0/$PENTOO_X64/boot/pentoo
        INITRD $FILE_BASE$NFS_ETH0/$PENTOO_X64/boot/pentoo.igz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$PENTOO_X64 ro real_root=/dev/nfs root=/dev/ram0 init=/linuxrc overlayfs looptype=squashfs loop=/image.squashfs cdroot nox secureconsole max_loop=256 dokeymap video=uvesafb:mtrr:3,ywrap,1024x768-16 console=tty0 scsi_mod.use_blk_mq=1 net.ifnames=0 ipv6.autoconf=0 --
        TEXT HELP
            Boot to Pentoo x64 Live
            User: pentoo
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$RPDESKTOP_X86/live/vmlinuz2" ]]; then
    echo  -e "\e[36m    add $RPDESKTOP_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $RPDESKTOP_X86
        MENU LABEL Raspberry Pi Desktop
        KERNEL $FILE_BASE$NFS_ETH0/$RPDESKTOP_X86/live/vmlinuz2
        INITRD $FILE_BASE$NFS_ETH0/$RPDESKTOP_X86/live/initrd2.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$RPDESKTOP_X86 ro netboot=nfs boot=live config -- locales=$CUSTOM_LOCALE keyboard-layouts=$CUSTOM_LAYOUTCODE utc=no timezone=$CUSTOM_TIMEZONE
        TEXT HELP
            Boot to Raspberry Pi Desktop
            User: pi, Password: raspberry
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$SYSTEMRESCUE_X64/sysresccd/boot/x86_64/vmlinuz" ]]; then
    echo  -e "\e[36m    add $SYSTEMRESCUE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $SYSTEMRESCUE_X64
        MENU LABEL System Rescue x64
        KERNEL $FILE_BASE$NFS_ETH0/$SYSTEMRESCUE_X64/sysresccd/boot/x86_64/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$SYSTEMRESCUE_X64/sysresccd/boot/intel_ucode.img,$FILE_BASE$NFS_ETH0/$SYSTEMRESCUE_X64/sysresccd/boot/amd_ucode.img,$FILE_BASE$NFS_ETH0/$SYSTEMRESCUE_X64/sysresccd/boot/x86_64/sysresccd.img
        #APPEND archisobasedir=sysresccd archiso_nfs_srv=$IP_ETH0:$DST_NFS_ETH0/$SYSTEMRESCUE_X64
        APPEND ip=dhcp archisobasedir=sysresccd archiso_http_srv=$FILE_BASE$NFS_ETH0/$SYSTEMRESCUE_X64/
        #SYSAPPEND 3
        TEXT HELP
            Boot to System Rescue x64 Live
            User: root
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$TAILS_X64/live/vmlinuz" ]]; then
    if ! [[ -f "$DST_NFS_ETH0/$TAILS_X64-hotfix-pxe.cpio.xz" ]]; then
        #echo  -e "\e[36m    download patch for $TAILS_X64\e[0m";
        #sudo wget --quiet -O $DST_NFS_ETH0/$TAILS_X64-hotfix-pxe.cpio.xz https://github.com/beta-tester/RPi-PXE-Server/files/?/$TAILS_X64-hotfix-pxe.cpio.xz
        :
    fi
    if [[ -f "$DST_NFS_ETH0/$TAILS_X64-hotfix-pxe.cpio.xz" ]]; then
        echo  -e "\e[36m    add $TAILS_X64\e[0m";
        cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## INFO: how to create $DST_NFS_ETH0/$TAILS_X64-hotfix-pxe.cpio.xz
    ##       see:
    ##         https://github.com/beta-tester/RPi-PXE-Server/issues/31
    ########################################
    LABEL $TAILS_X64
        MENU LABEL Tails x64
        KERNEL $FILE_BASE$NFS_ETH0/$TAILS_X64/live/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$TAILS_X64/live/initrd.img,$FILE_BASE$NFS_ETH0/$TAILS_X64-hotfix-pxe.cpio.xz
        APPEND ip=dhcp fetch=$FILE_BASE$NFS_ETH0/$TAILS_X64/live/filesystem.squashfs ro boot=live config live-media=removable ipv6.disable=1 nopersistence noprompt block.events_dfl_poll_msecs=1000 noautologin module=Tails slab_nomerge slub_debug=FZP mce=0 vsyscall=none page_poison=1 init_on_alloc=1 init_on_free=1 mds=full,nosmt timezone=Etc/UTC -- keyboard-layouts=$CUSTOM_LAYOUTCODE
        TEXT HELP
            Boot to Tails x64 Live
        ENDTEXT
EOF
    else
        echo  -e "\e[1;31m    failed $TAILS_X64,\e[0m"
        echo  -e "\e[1;31m        please visit: https://github.com/beta-tester/RPi-PXE-Server/issues/31\e[0m";
    fi
fi
#========== END ==========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$TINYCORE_X64/boot/vmlinuz64" ]]; then
    echo  -e "\e[36m    add $TINYCORE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    # INFO: http://wiki.tinycorelinux.net/wiki:boot_options
    LABEL $TINYCORE_X64
        MENU LABEL tiny core x64
        KERNEL $FILE_BASE$NFS_ETH0/$TINYCORE_X64/boot/vmlinuz64
        INITRD $FILE_BASE$NFS_ETH0/$TINYCORE_X64/boot/corepure64.gz
        APPEND ip=dhcp nfsmount=$IP_ETH0:$DST_NFS_ETH0/$TINYCORE_X64 tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 -- lang=en kmap=qwertz/de-latin1 noswap norestore
        #APPEND ip=dhcp nfsmount=$IP_ETH0:$DST_NFS_ETH0/$TINYCORE_X64.rw tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 -- lang=en kmap=qwertz/de-latin1 noswap norestore
        #APPEND ip=dhcp httplist=$IP_ETH0$DST_NFS_ETH0/tinycore-x64.xbase.lst vga=791 loglevel=3 -- lang=en kmap=qwertz/de-latin1 tz=Europe/Berlin noswap norestore settime showapps pause
        TEXT HELP
            Boot to tiny core x64
            User: tc
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$TINYCORE_X64/boot/vmlinuz64" ]]; then
    echo  -e "\e[36m    add $TINYCORE_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    # INFO: http://wiki.tinycorelinux.net/wiki:boot_options
    LABEL $TINYCORE_X64 (ISO)
        MENU LABEL tiny core x64 (ISO)
        KERNEL memdisk
        APPEND iso
        INITRD $FILE_BASE$ISO/$TINYCORE_X64.iso
        TEXT HELP
            Boot to tiny core x64
            User: tc
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$TINYCORE_X86/boot/vmlinuz" ]]; then
    echo  -e "\e[36m    add $TINYCORE_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    # INFO: http://wiki.tinycorelinux.net/wiki:boot_options
    LABEL $TINYCORE_X86
        MENU LABEL tiny core x86
        KERNEL $FILE_BASE$NFS_ETH0/$TINYCORE_X86/boot/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$TINYCORE_X86/boot/core.gz
        APPEND nfsmount=$IP_ETH0:$DST_NFS_ETH0/$TINYCORE_X86 tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 -- lang=en kmap=qwertz/de-latin1 noswap norestore
        #APPEND ip=dhcp nfsmount=$IP_ETH0:$DST_NFS_ETH0/$TINYCORE_X86.rw tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 -- lang=en kmap=qwertz/de-latin1 noswap norestore
        TEXT HELP
            Boot to tiny core x86
            User: tc
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_DAILY_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_DAILY_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_DAILY_X64
        MENU LABEL Ubuntu x64 Daily-Live
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_DAILY_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_DAILY_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_DAILY_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu x64 Daily-Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_FWTS/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_FWTS\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## INFO: https://wiki.ubuntu.com/FirmwareTestSuite/
    ##       https://wiki.ubuntu.com/FirmwareTestSuite/Reference
    ##       http://fwts.ubuntu.com/fwts-live/?C=M;O=D
    LABEL $UBUNTU_FWTS
        MENU LABEL Ubuntu Live FirmwareTestSuite
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_FWTS/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_FWTS/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_FWTS ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper toram --
        TEXT HELP
            Boot to Ubuntu Live FirmwareTestSuite
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_LTS_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_LTS_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_LTS_X64
        MENU LABEL Ubuntu LTS x64
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_LTS_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_LTS_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_LTS_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper systemd.mask=tmp.mount -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu LTS x64 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_LTS_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_LTS_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_LTS_X86
        MENU LABEL Ubuntu LTS x86
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_LTS_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_LTS_X86/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_LTS_X86 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu LTS x86 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_STUDIO_DAILY_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_STUDIO_DAILY_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_STUDIO_DAILY_X64
        MENU LABEL Ubuntu Studio x64 Daily-Live
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_STUDIO_DAILY_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_STUDIO_DAILY_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_STUDIO_DAILY_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu Studio x64 Daily-Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_STUDIO_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_STUDIO_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_STUDIO_X64
        MENU LABEL Ubuntu Studio x64
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_STUDIO_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_STUDIO_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_STUDIO_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu Studio x64 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_X64
        MENU LABEL Ubuntu x64
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_X64/casper/initrd
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu x64 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_X86
        MENU LABEL Ubuntu x86
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_X86/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_X86 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu x86 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========



########################################################################
#custom#

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DESINFECT_X86/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DESINFECT_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DESINFECT_X86
        MENU LABEL desinfect x86
        KERNEL $FILE_BASE$NFS_ETH0/$DESINFECT_X86/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DESINFECT_X86/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DESINFECT_X86 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper memtest=4 rmdns -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to ct desinfect x86
            User: desinfect
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$DESINFECT_X64/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $DESINFECT_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $DESINFECT_X64
        MENU LABEL desinfect x64
        KERNEL $FILE_BASE$NFS_ETH0/$DESINFECT_X64/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$DESINFECT_X64/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$DESINFECT_X64 ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper memtest=4 rmdns -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to ct desinfect x64
            User: desinfect
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$UBUNTU_NONPAE/casper/vmlinuz" ]]; then
    echo  -e "\e[36m    add $UBUNTU_NONPAE\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $UBUNTU_NONPAE
        MENU LABEL Ubuntu non-PAE x86
        KERNEL $FILE_BASE$NFS_ETH0/$UBUNTU_NONPAE/casper/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$UBUNTU_NONPAE/casper/initrd.lz
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$UBUNTU_NONPAE ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper -- debian-installer/locale=$CUSTOM_LOCALE console-setup/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/layoutcode=$CUSTOM_LAYOUTCODE keyboard-configuration/variant=$CUSTOM_VARIANT
        TEXT HELP
            Boot to Ubuntu non-PAE x86 Live
            User: ubuntu
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_TFTP_ETH0/$1/pxeboot.n12" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X86 (PXE)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X86-pxe
        MENU LABEL Windows PE x86 (PXE)
        PXE pxeboot.n12
        TEXT HELP
            Boot to Windows PE 32bit
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_ISO/$WIN_PE_X86.iso" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X86 (ISO)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X86-iso
        MENU LABEL Windows PE x86 (ISO)
        KERNEL memdisk
        APPEND iso raw
        INITRD $FILE_BASE$ISO/$WIN_PE_X86.iso
        TEXT HELP
            Boot to Windows PE 32bit ISO ~400MB
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_TFTP_ETH0/$1/wimboot" ]] \
&& [[ -f "$DST_NFS_ETH0/$WIN_PE_X86/sources/boot.wim" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X86 (WIM)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X86-wim
        MENU LABEL Windows PE x86 (WIM)
        COM32 linux.c32 wimboot
        APPEND initrdfile=$FILE_BASE$NFS_ETH0/$WIN_PE_X86/Boot/BCD,$FILE_BASE$NFS_ETH0/$WIN_PE_X86/Boot/boot.sdi,$FILE_BASE$NFS_ETH0/$WIN_PE_X86/sources/boot.wim
        TEXT HELP
            Boot to Windows PE 32bit
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_TFTP_ETH0/$1/pxeboot.n12" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X64 (PXE)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X64-pxe
        MENU LABEL Windows PE x64 (PXE)
        PXE pxeboot.n12
        TEXT HELP
            Boot to Windows PE 64bit
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_ISO/$WIN_PE_X64.iso" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X64 (ISO)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X64-iso
        MENU LABEL Windows PE x64 (ISO)
        KERNEL memdisk
        APPEND iso raw
        INITRD $FILE_BASE$ISO/$WIN_PE_X64.iso
        TEXT HELP
            Boot to Windows PE 64bit ISO ~400MB
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_TFTP_ETH0/$1/wimboot" ]] \
&& [[ -f "$DST_NFS_ETH0/$WIN_PE_X64/sources/boot.wim" ]]; then
    echo  -e "\e[36m    add $WIN_PE_X64 (WIM)\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    LABEL $WIN_PE_X64-wim
        MENU LABEL Windows PE x64 (WIM)
        COM64 linux.c64 wimboot
        APPEND initrdfile=$FILE_BASE$NFS_ETH0/$WIN_PE_X64/Boot/BCD,$FILE_BASE$NFS_ETH0/$WIN_PE_X64/Boot/boot.sdi,$FILE_BASE$NFS_ETH0/$WIN_PE_X64/sources/boot.wim
        TEXT HELP
            Boot to Windows PE 64bit
        ENDTEXT
EOF
fi
#=========== END ===========



########################################################################
#broken#

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$ANDROID_X86/kernel" ]]; then
    echo  -e "\e[36m    add $ANDROID_X86\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## NOT WORKING
    LABEL $ANDROID_X86
        MENU LABEL Android x86 (broken)
        KERNEL $FILE_BASE$NFS_ETH0/$ANDROID_X86/kernel
        INITRD $FILE_BASE$NFS_ETH0/$ANDROID_X86/initrd.img
        APPEND ip=dhcp nfsroot=$IP_ETH0:$DST_NFS_ETH0/$ANDROID_X86 ro netboot=nfs root=/dev/ram0 androidboot.selinux=permissive SRC= DATA=
        TEXT HELP
            Boot to Android x86 Live
            User: root
        ENDTEXT
EOF
fi
#=========== END ===========

#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]] \
&& [[ -f "$DST_NFS_ETH0/$CENTOS_X64/isolinux/vmlinuz" ]]; then
    echo  -e "\e[36m    add $CENTOS_X64\e[0m";
    cat << EOF | sudo tee -a $FILE_MENU &>/dev/null
    ########################################
    ## NOT WORKING
    ## INFO: http://people.redhat.com/harald/dracut.html#dracut.kernel
    ##       https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/chap-installation-server-setup
    ##       https://github.com/haraldh/dracut/blob/master/dracut.cmdline.7.asc
    LABEL $CENTOS_X64
        MENU LABEL CentOS x64 (broken)
        KERNEL $FILE_BASE$NFS_ETH0/$CENTOS_X64/isolinux/vmlinuz
        INITRD $FILE_BASE$NFS_ETH0/$CENTOS_X64/isolinux/initrd.img
        #APPEND ip=dhcp root=live:nfs:$IP_ETH0$DST_NFS_ETH0/$CENTOS_X64 ro rootfstype=auto rd.live.image rhgb rd.lvm=0 rd.luks=0 rd.md=0 rd.dm=0 rd.shell rd.break console=tty0 loglevel=7 vga=794 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE

    # dracut: FATAL: Don't know how to handle 'root=live:nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64';
        #APPEND ip=dhcp root=live:nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64 ro root-path=/LiveOS/squashfs.img rootfstype=squashfs rd.live.image rd.live.ram=1 rd.live.overlay=none rd.luks=0 rd.md=0 rd.dm=0 vga=794 rd.shell log_buf_len=1M rd.retry=10 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE

    # dracut: FATAL: Don't know how to handle 'root=live:nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64/LiveOS/squashfs.img';
        #APPEND ip=dhcp root=live:nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64/LiveOS/squashfs.img ro rootfstype=squashfs rd.live.image rd.live.ram=1 rd.live.overlay=none rd.luks=0 rd.md=0 rd.dm=0 vga=794 rd.shell log_buf_len=1M rd.retry=10 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE

    # mount.nfs: mountpoint /sysroot is not a directory
        #APPEND ip=dhcp root=nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64/LiveOS/squashfs.img ro root-path=/LiveOS/squashfs.img rootfstype=squashfs rd.live.image rd.live.ram=1 rd.live.overlay=none rd.luks=0 rd.md=0 rd.dm=0 vga=794 rd.shell log_buf_len=1M rd.retry=10 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE

    # Warning: Could not boot.
        # Warning: /dev/mapper/live-rw does not exist
        # Starting Dracut Emergency Shell
        APPEND ip=dhcp root=nfs:$IP_ETH0:$DST_NFS_ETH0/$CENTOS_X64 ro root-path=/LiveOS/squashfs.img rootfstype=squashfs rd.live.image rd.live.ram=1 rd.live.overlay=none rd.luks=0 rd.md=0 rd.dm=0 vga=794 rd.shell log_buf_len=1M rd.retry=10 -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=$CUSTOM_KEYMAP locale.LANG=$CUSTOM_LOCALE

        TEXT HELP
            Boot to CentOS LiveGNOME
            User: liveuser
        ENDTEXT
EOF
fi
#========== END ==========


else


########################################################################
## ipxe
#========== BEGIN ==========
if [[ -f "$FILE_MENU" ]]; then
    echo  -e "\e[36m    add ipxe menu\e[0m";
    cat << EOF | sudo tee $FILE_MENU &>/dev/null
#!ipxe

# 2021-01-30
# made by https://github.com/beta-tester
# for project https://github.com/beta-tester/RPi-PXE-Server


########################################################################
### CHAIN LOAD SERVER VERSION OF iPXE
:begin_ipxe_chainload_serverversion
iseq \${product} VirtualBox || goto end_ipxe_chainload_serverversion
set version_vbox 1.0.0+
iseq \${version} \${version_vbox} || goto end_ipxe_chainload_serverversion
:ipxe_chainload_serverversion
echo download iPXE
iseq \${platform} efi && set ipxe_file ipxe.efi || set ipxe_file undionly.kpxe
imgfree ||
chain \${ipxe_file}
exit
:end_ipxe_chainload_serverversion


########################################################################
### VARIABLES
set base       http://\${next-server}/srv/nfs
set nfsroot    \${next-server}:/srv/nfs

set keymap     $CUSTOM_KEYMAP
set kmap       $CUSTOM_KMAP
set language   $CUSTOM_LANGUAGE
set layoutcode $CUSTOM_LAYOUTCODE
set locale     $CUSTOM_LOCALE
set timezone   $CUSTOM_TIMEZONE
set variant    $CUSTOM_VARIANT


# Figure out if client is 64-bit capable
cpuid --ext 29 && set archx x64 || set archx x86
cpuid --ext 29 && set arch amd64 || set arch i386
cpuid --ext 29 && set arch2 amd64 || set arch2 i686
cpuid --ext 29 && set bit_cpu 64 || set bit_cpu 32

# Figure out if BIOS, EFI32 or EFI64
:begin_test_bios
iseq \${platform} efi && goto test_bios_is_efi ||
set pxe_menu menu-bios
goto end_test_bios
:test_bios_is_efi
cpuid --ext 29 && set pxe_menu menu-efi64 || set pxe_menu menu-efi32
:end_test_bios

########################################################################
### MAIN MENU
:start
imgfree
menu iPXE \${version}, \${platform}, \${archx}, \${next-server}, \${pxe_menu}
item --gap --               ------------------------- Live Operating systems -------------------------
item arch-netboot-x64       Boot Arch netboot x64
item debian-x64             Boot Debian x64
item devuan-x64             Boot Devuan x64
item fedora-x64             Boot Fedora x64
item mint-x64               Boot Linux Mint x64
item opensuse-x64           Boot openSUSE x64
item tinycore-x64           Boot Tiny Core x64
item ubuntu-x64             Boot Ubuntu x64
item --gap --               ------------------------- Pentesting systems ------------------------------
item blackarch-x64          Boot BlackArch x64
item kali-x64               Boot Kali x64
item parrot-full-x64        Boot Parrot x64
item pentoo-x64             Boot Pentoo x64
item --gap --               ------------------------- Virus scanner systems ---------------------------
item desinfect-x64          Boot Desinfec't x64
item desinfect-x86          Boot Desinfec't x86
item eset-rescue-x86        Boot ESET SysRescue Live x86
item kaspersky-rescue-x86   Boot Kaspersky Rescue Disk x86
item --gap --               ------------------------- Other systems ----------------------------------
item clonezilla-x64         Boot Clonezilla x64
item dragonos-x64           Boot DragonOS x64
item gnuradio-x64           Boot GNU Radio x64
item knoppix-x86            Boot Knoppix x86
item opensuse-rescue-x64    Boot openSUSE Rescue x64
item rpdesktop-x86          Boot Raspberry Pi Desktop
item systemrescue-x64       Boot System Rescue x64
item ubuntu-studio-x64      Boot Ubuntu Studio x64
item --gap --               ------------------------- Windows systems ----------------------------------
item windows-iso-x64        Boot Windows PE x64 (ISO via http)
item windows-iso-x86        Boot Windows PE x86 (ISO via http)
item windows-pxe-x64        Boot Windows PE x64 (PXE via tftp)
item windows-pxe-x86        Boot Windows PE x86 (PXE via tftp)
item windows-wim-x64        Boot Windows PE x64 (WIM via http)
item windows-wim-x86        Boot Windows PE x86 (WIM via http)
item --gap --               ------------------------- Broken systems ----------------------------------
item tails-x64              Boot Tails x64
item --gap --               ------------------------- Tools and utilities ----------------------------
item --key p pxelinux       Boot PXE Linux
item --gap --               ------------------------- Advanced options -------------------------------
item --key c config         Configure settings
item shell                  Drop to iPXE shell
item reboot                 Reboot computer
item poweroff               Power off computer
item --gap --               --------------------------------------------------------------------------
item --key x exit           Exit iPXE and continue BIOS boot
choose os || goto cancel
echo \${os}
goto \${os}


:cancel
echo You cancelled the menu, dropping you to the shell

:shell
echo Type 'exit' to get the back to the menu
shell
goto start

:failed
echo Action failed, dropping you to the shell
goto shell

:reboot
reboot || goto failed

:poweroff
poweroff || goto failed

:exit
exit

:config
config
goto start


########################################################################
###
:arch-netboot-x64
#imgselect  http://www.archlinux.org/static/netboot/ipxe.lkrn  || goto failed
imgselect  \${base}/\${os}/kernel  || goto failed
imgexec                          || goto failed
goto start


########################################################################
### ubuntu based
:dragonos-x64
set ext2 .gz
goto ubuntu

:eset-rescue-x86
:mint-x64
:ubuntu-x86
:desinfect-x64
:desinfect-x86
set ext2 .lz
goto ubuntu

:gnuradio-x64
set ext1 .efi
set ext2 .lz
goto ubuntu

:kubuntu-daily-x64
:kubuntu-x64
:lubuntu-daily-x64
:lubuntu-x64
:ubuntu-daily-x64
:ubuntu-studio-daily-x64
:ubuntu-studio-x64
:ubuntu-x64
:xubuntu-daily-x64
:xubuntu-x64
goto ubuntu

:ubuntu
#set custom   -- debian-installer/locale=\${locale} debian-installer/language=\${language} console-setup/layoutcode=\${layoutcode} keyboard-configuration/layoutcode=\${layoutcode} keyboard-configuration/variant=\${variant}
set custom   -- debian-installer/locale=\${locale} console-setup/layoutcode=\${layoutcode} keyboard-configuration/layoutcode=\${layoutcode} keyboard-configuration/variant=\${variant}
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs file=/cdrom/preseed/ubuntu.seed boot=casper memtest=4 rmdns
imgselect  \${base}/\${os}/casper/vmlinuz\${ext1}  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/casper/initrd\${ext2}                          || goto failed
imgexec                                                                || goto failed
goto start


########################################################################
### debian based
:debian-cinnamon-x64
:debian-cinnamon-x86
:debian-gnome-x64
:debian-gnome-x86
:debian-kde-x64
:debian-kde-x86
:debian-lxde-x64
:debian-lxde-x86
:debian-lxqt-x64
:debian-lxqt-x86
:debian-mate-x64
:debian-mate-x86
:debian-x64
:debian-x86
set version  $DEBIAN_KVER
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live config
imgselect  \${base}/\${os}/live/vmlinuz-\${version}-\${arch}  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img-\${version}-\${arch}                      || goto failed
imgexec                                                                          || goto failed
goto start


:devuan-x64
:devuan-x86
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live username=devuan config
imgselect  \${base}/\${os}/live/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img                      || goto failed
imgexec                                                       || goto failed
goto start


:rpdesktop-x86
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live config
imgselect  \${base}/\${os}/live/vmlinuz2  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd2.img                      || goto failed
imgexec                                                        || goto failed
goto start


########################################################################
###
:fedora-x64
set custom   -- vconsole.font=latarcyrheb-sun16 vconsole.keymap=\${keymap} locale.LANG=\${locale}
set options  ip=dhcp root=live:nfs://\${next-server}/srv/nfs/\${os}/LiveOS/squashfs.img ro rd.live.image rd.lvm=0 rd.luks=0 rd.md=0 rd.dm=0 vga=794
imgselect  \${base}/\${os}/isolinux/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/isolinux/initrd.img                      || goto failed
imgexec                                                           || goto failed
goto start


########################################################################
###
:opensuse-rescue-x64
set aoe_if e0.1
goto opensuse

:opensuse-x64
set aoe_if e1.1
goto opensuse

:opensuse
set custom   --
set options  ip=dhcp root=live:AOEINTERFACE=\${aoe_if} rd.kiwi.live.pxe
imgselect  \${base}/\${os}/boot/x86_64/loader/linux  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/boot/x86_64/loader/initrd                        || goto failed
imgexec                                                                   || goto failed
goto start


########################################################################
###
:tinycore-x64
:tinycore-x86
set custom   -- lang=en kmap=\${kmap}
set options  ip=dhcp nfsmount=\${nfsroot}/\${os} tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 noswap norestore
#set options  ip=dhcp nfsmount=\${nfsroot}/\${os}.rw tce=/mnt/nfs/cde waitusb=5 vga=791 loglevel=3 noswap norestore
imgselect  \${base}/\${os}/boot/vmlinuz64  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/boot/corepure64.gz                     || goto failed
imgexec                                                         || goto failed
goto start


########################################################################
###
:blackarch-x64
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp archiso_nfs_srv=\${nfsroot}/\${os} ro archisobasedir=blackarch copytoram=n
imgselect  \${base}/\${os}/blackarch/boot/x86_64/vmlinuz-linux  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/blackarch/boot/intel-ucode.img                              || goto failed
imgfetch   \${base}/\${os}/blackarch/boot/amd-ucode.img                                || goto failed
imgfetch   \${base}/\${os}/blackarch/boot/x86_64/initramfs-linux.img                   || goto failed
imgexec                                                                              || goto failed
goto start


########################################################################
###
:systemrescue-x64
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp archiso_nfs_srv=\${nfsroot}/\${os} ro archisobasedir=sysresccd copytoram=n
imgselect  \${base}/\${os}/sysresccd/boot/x86_64/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/sysresccd/boot/intel_ucode.img                        || goto failed
imgfetch   \${base}/\${os}/sysresccd/boot/amd_ucode.img                          || goto failed
imgfetch   \${base}/\${os}/sysresccd/boot/x86_64/sysresccd.img                   || goto failed
imgexec                                                                        || goto failed
goto start


########################################################################
###
:kali-x64
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} timezone=\${timezone} utc=no
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live noconfig=sudo username=kali hostname=kali
imgselect  \${base}/\${os}/live/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img                      || goto failed
imgexec                                                       || goto failed
goto start


########################################################################
###
:parrot-full-x64
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} pkeys=\${kmap} setxkbmap=\${kmap} timezone=\${timezone} utc=no
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live config
imgselect  \${base}/\${os}/live/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img                      || goto failed
imgexec                                                       || goto failed
goto start


########################################################################
###
:pentoo-beta-x64
:pentoo-x64
set custom   --
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro real_root=/dev/nfs root=/dev/ram0 init=/linuxrc overlayfs looptype=squashfs loop=/image.squashfs cdroot nox secureconsole max_loop=256 dokeymap video=uvesafb:mtrr:3,ywrap,1024x768-16 console=tty0 scsi_mod.use_blk_mq=1 net.ifnames=0 ipv6.autoconf=0
imgselect  \${base}/\${os}/boot/pentoo  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/boot/pentoo.igz                     || goto failed
imgexec                                                      || goto failed
goto start


########################################################################
###
:kaspersky-rescue-x86
set custom   -- lang=us setkmap=us
set options  ip=dhcp netboot=nfs://\${nfsroot}/\${os} ro dostartx
imgselect  \${base}/\${os}/boot/grub/k-x86  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/boot/grub/initrd.xz                     || goto failed
imgexec                                                          || goto failed
goto start


########################################################################
###
:clonezilla-x64
:clonezilla-x86
set custom   -- locales=\${locale} keyboard-layouts=\${layoutcode} utc=no timezone=\${timezone}
set options  ip=dhcp nfsroot=\${nfsroot}/\${os} ro netboot=nfs boot=live config username=user hostname=clonezilla union=overlay components noswap edd=on nomodeset nodmraid ocs_live_run=ocs-live-general ocs_live_extra_param= ocs_live_batch=no net.ifnames=0 nosplash noprompt
imgselect  \${base}/\${os}/live/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img                      || goto failed
imgexec                                                       || goto failed
goto start


########################################################################
###
:knoppix-x86
set custom   -- lang=de
set options  ip=dhcp nfsdir=\${nfsroot}/\${os} nodhcp ramdisk_size=100000 init=/sbin/init apm=power-off nomce loglevel=1 libata.force=noncq tz=localtime hpsa.hpsa_allow_any=1 BOOT_IMAGE=knoppix
imgselect  \${base}/\${os}/boot/isolinux/linux  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}-miniroot-8.6.1.gz                           || goto failed
imgexec                                                              || goto failed
goto start


########################################################################
###
:tails-x64
set custom   -- keyboard-layouts=\${lasyoutcode}
set options  ip=dhcp BOOTIF=\${hwaddr} fetch=\${base}/\${os}/live/filesystem.squashfs ro boot=live config live-media=removable ipv6.disable=1 nopersistence noprompt block.events_dfl_poll_msecs=1000 noautologin module=Tails slab_nomerge slub_debug=FZP mce=0 vsyscall=none page_poison=1 init_on_alloc=1 init_on_free=1 mds=full,nosmt timezone=Etc/UTC debug ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 earlyprintk=vga,keep sched_debug
imgselect  \${base}/\${os}/live/vmlinuz  \${options}  \${custom}  || goto failed
imgfetch   \${base}/\${os}/live/initrd.img                      || goto failed
imgfetch   \${base}/\${os}-hotfix-pxe.cpio.xz                   || goto failed
imgexec                                                       || goto failed
goto start


########################################################################
###
:windows-iso-x64
set os win-pe-x64
goto windows-iso

:windows-iso-x86
set os win-pe-x86
goto windows-iso

:windows-iso
imgselect  memdisk iso raw                          || goto failed
imgfetch   http://\${next-server}/srv/iso/\${os}.iso  || goto failed
imgexec                                             || goto failed
goto start


# https://git.ipxe.org/releases/wimboot/
:windows-wim-x64
set os win-pe-x64
goto windows-wim

:windows-wim-x86
set os win-pe-x86
goto windows-wim

:windows-wim
imgselect  wimboot                                                || goto failed
imgfetch   \${base}/\${os}/bootmgr                   bootmgr        || goto failed
imgfetch   \${base}/\${os}/Boot/BCD                  BCD            || goto failed
imgfetch   \${base}/\${os}/Boot/Fonts/wgl4_boot.ttf  wgl4_boot.ttf  || goto failed
imgfetch   \${base}/\${os}/Boot/boot.sdi             boot.sdi       || goto failed
imgfetch   \${base}/\${os}/sources/boot.wim          boot.wim       || goto failed
imgexec                                                           || goto failed
goto start


:windows-pxe-x86
goto windows-pxe

:windows-pxe-x64
goto windows-pxe

:windows-pxe
#set 67:string pxeboot.n12
#set 17:string \${pxe_menu}
iseq \${platform} efi && set boot-file bootmgr.efi || set boot-file pxeboot.n12
imgselect  \${pxe_menu}/\${boot-file}  || goto failed
#imgselect  \${pxe_menu}/pxeboot.n12  || goto failed
#imgselect  http://\${next-server}/srv/iso/Boot.amd64/PXE/wdsnbp.com  || goto failed
#imgselect  http://\${next-server}/srv/iso/Boot.amd64/PXE/bootmgr.exe  || goto failed
#imgselect  http://\${next-server}/srv/iso/Boot.amd64/PXE/bootmgr.efi  || goto failed
imgexec    || goto failed
goto start


########################################################################
###
:pxelinux
set 209:string /pxelinux.cfg/default
set 210:string \${pxe_menu}
imgselect  \${210:string}/lpxelinux.0  || goto failed
imgexec                               || goto failed
goto start

EOF
fi
#========== END ==========

fi
