# Filename:
#   fedora-livecd-security.ks
# Description:
#   A fully functional live OS based on Fedora for use in security auditing, forensics research, and penetration testing.
# Maintainers:
#   Luke Macken
#   Adam Miller <maxamillion [AT] fedoraproject.org>
#   Joerg Simon
# Acknowledgements:
#   Fedora LiveCD Xfce Spin team - some work here was inherited, many thanks!

%include fedora-live-base.ks

%packages
-fedora-logos
generic-logos

firefox
yum-presto
midori
cups-pdf
gnome-bluetooth
alsa-plugins-pulseaudio
pavucontrol

# Command line
ntfs-3g
powertop
wget
irssi
mutt
yum-utils
cnetworkmanager

gdm
Thunar 
gtk-xfce-engine
thunar-volman
xarchiver

# dictionaries are big
#-aspell-*
#-man-pages-*

# more fun with space saving
-gimp-help

#GUI Stuff
@lxde

# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid
# system-config-printer does printer management better
# xfprint has now been made as optional in comps.
system-config-printer

###################### Security Stuffs ############################
# Reconnaissance
dsniff
hping3
nc6
nc
nessus-client
nessus-gui
nessus-server
ngrep
nmap
nmap-frontend
p0f
sing
scanssh
scapy
socat
tcpdump
tiger
unicornscan
wireshark-gnome
xprobe2
nbtscan
tcpxtract
firewalk
hunt
halberd
argus
nbtscan
ettercap
ettercap-gtk
iptraf
pcapdiff
picviz
etherape
lynis

# Forensics
chkrootkit
clamav
dd_rescue
gparted
hexedit
prelude-lml
testdisk
foremost
mhonarc
sectool-gui
rkhunter
scanmem
sleuthkit
unhide
examiner
dc3dd

# Wireless
aircrack-ng
airsnort
kismet

# Code analysis
splint
pscan
flawfinder
rats

# Intrusion detection
snort
aide
tripwire
labrea
honeyd
pads
prewikka
prelude-notify
prelude-manager
nebula

# Password cracking
john
ophcrack

# Anonymity
tor

# under review (#461385)
#hydra

# Useful tools
lsof
ntop
scrot
mc

# Other necessary components
screen
desktop-backgrounds-basic
feh
vim-enhanced
gnome-menus
gnome-terminal
PolicyKit-gnome

# make sure debuginfo doesn't end up on the live image
-*debuginfo


%end

%post
sed -i -e 's/Fedora/Generic/g' /etc/fedora-release
#Add the menu rpm, this hack is till package has been approved
rpm -ivh security-menu-1.0-4.fc12.noarch.rpm

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 30 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=30
FOE
#last thing to do
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF

%end

