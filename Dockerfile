FROM debian:stretch

# Install samba
RUN export DEBIAN_FRONTEND='noninteractive' && \
    echo 'deb https://download.webmin.com/download/repository sarge contrib' >>/etc/apt/sources.list
    cd /root && wget http://www.webmin.com/jcameron-key.asc
    apt-key add jcameron-key.asc
    apt-get update && apt-get install -qy --no-install-recommends webmin apt-transport-https samba smbclient samba-vfs-modules ntp cifs-utils usbmount rsync curl
    mv /etc/samba/smb.conf /etc/samba/smb.conf.bck
    echo '[global]' >>/etc/samba/smb.conf && \
    echo '   workgroup = WORKGROUP' >>/etc/samba/smb.conf && \
    echo '   dns proxy = no' >>/etc/samba/smb.conf && \
    echo '   security = user' >>/etc/samba/smb.conf && \
    echo '   server string = Samba Server Version %v' >>/etc/samba/smb.conf && \
    echo '   interfaces = 10.1.1.0/24 192.168.1.0/24' >>/etc/samba/smb.conf && \
    echo '   bind interfaces only = yes' >>/etc/samba/smb.conf && \
    echo '   log file = /var/log/samba/log.%m' >>/etc/samba/smb.conf && \
    echo '   max log size = 1000' >>/etc/samba/smb.conf && \
    echo '   log level = 1' >>/etc/samba/smb.conf && \
    echo '   syslog = 0' >>/etc/samba/smb.conf && \
    echo '   panic action = /usr/share/samba/panic-action %d' >>/etc/samba/smb.conf && \
    echo '   server role = standalone server' >>/etc/samba/smb.conf && \
    echo '   passdb backend = tdbsam' >>/etc/samba/smb.conf && \
    echo '   obey pam restrictions = yes' >>/etc/samba/smb.conf && \
    echo '   passwd program = /usr/bin/passwd %u' >>/etc/samba/smb.conf && \
    echo '   unix password sync = yes' >>/etc/samba/smb.conf && \
    echo '   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .' >>/etc/samba/smb.conf && \
    echo '   pam password change = yes' >>/etc/samba/smb.conf && \
    echo '   map to guest = bad user' >>/etc/samba/smb.conf && \
    echo '   smb encrypt = auto' >>/etc/samba/smb.conf && \
    echo '   server max protocol = SMB3' >>/etc/samba/smb.conf && \
    echo '############ Misc ############' >>/etc/samba/smb.conf && \
    echo ';   include = /home/samba/etc/smb.conf.%m' >>/etc/samba/smb.conf && \
    echo '   usershare max shares = 0' >>/etc/samba/smb.conf && \
    echo '   usershare allow guests = no' >>/etc/samba/smb.conf && \
    echo '' >>/etc/samba/smb.conf && \
    echo '#======================= Share Definitions =======================' >>/etc/samba/smb.conf && \
    echo '[public]' >>/etc/samba/smb.conf && \
	echo 'path = /home/public' >>/etc/samba/smb.conf && \
	echo 'comment = Public Directory' >>/etc/samba/smb.conf && \
	echo 'valid users = @groupPublic, @groupSecret' >>/etc/samba/smb.conf && \
	echo 'browseable = yes' >>/etc/samba/smb.conf && \
	echo 'directory mode = 770' >>/etc/samba/smb.conf && \
	echo 'writeable = yes' >>/etc/samba/smb.conf && \
	echo 'create mode = 770' >>/etc/samba/smb.conf && \
	echo 'guest ok = no' >>/etc/samba/smb.conf && \
	echo 'writable = yes' >>/etc/samba/smb.conf && \
	echo '#======================= Recycle Bin =======================' >>/etc/samba/smb.conf && \
	echo 'recycle:repository = /home/public/.trashPublic/%U' >>/etc/samba/smb.conf && \
	echo 'recycle:maxsize = 0' >>/etc/samba/smb.conf && \
	echo 'recycle:versions = yes' >>/etc/samba/smb.conf && \
	echo 'recycle:keeptree = yes' >>/etc/samba/smb.conf && \
	echo 'recycle:touch = no' >>/etc/samba/smb.conf && \
	echo 'recycle:directory_mode = 0770' >>/etc/samba/smb.conf && \
    echo 'recycle:exclude = *.tmp' >>/etc/samba/smb.conf && \
	echo 'recycle:exclude_dir = .trashPublic' >>/etc/samba/smb.conf && \
	echo 'audit:prefix = %u' >>/etc/samba/smb.conf && \
	echo 'audit:success = open opendir' >>/etc/samba/smb.conf && \
	echo 'audit:failure = all' >>/etc/samba/smb.conf && \
	echo 'audit:facility = LOCAL5' >>/etc/samba/smb.conf && \
	echo 'audit:priority = NOTICE' >>/etc/samba/smb.conf && \
	echo 'vfs object = recycle:recycle full_audit:audit' >>/etc/samba/smb.conf && \
	echo '[secret]' >>/etc/samba/smb.conf && \
	echo 'path = /home/secret' >>/etc/samba/smb.conf && \
    echo 'comment = Secret Directory' >>/etc/samba/smb.conf && \
	echo 'valid users = @groupSecret' >>/etc/samba/smb.conf && \
	echo 'browseable = yes' >>/etc/samba/smb.conf && \
	echo 'directory mode = 770' >>/etc/samba/smb.conf && \
	echo 'writeable = yes' >>/etc/samba/smb.conf && \
	echo 'create mode = 770' >>/etc/samba/smb.conf && \
	echo 'guest ok = no' >>/etc/samba/smb.conf && \
	echo 'writable = yes' >>/etc/samba/smb.conf && \
	echo '#======================= Recycle Bin =======================' >>/etc/samba/smb.conf && \
	echo 'recycle:repository = /home/secret/.trashSecret/%U' >>/etc/samba/smb.conf && \
	echo 'recycle:maxsize = 0' >>/etc/samba/smb.conf && \
	echo 'recycle:versions = yes' >>/etc/samba/smb.conf && \
	echo 'recycle:keeptree = yes' >>/etc/samba/smb.conf && \
	echo 'recycle:touch = no' >>/etc/samba/smb.conf && \
	echo 'recycle:directory_mode = 0770' >>/etc/samba/smb.conf && \
    echo 'recycle:exclude = *.tmp' >>/etc/samba/smb.conf && \
	echo 'recycle:exclude_dir = .trashSecret' >>/etc/samba/smb.conf && \
    echo 'audit:prefix = %u' >>/etc/samba/smb.conf && \
	echo 'audit:success = open opendir' >>/etc/samba/smb.conf && \
	echo 'audit:failure = all' >>/etc/samba/smb.conf && \
	echo 'audit:facility = LOCAL5' >>/etc/samba/smb.conf && \
	echo 'audit:priority = NOTICE' >>/etc/samba/smb.conf && \
	echo 'vfs object = recycle:recycle full_audit:audit' >>/etc/samba/smb.conf && \
	echo '# This share requires authentication to access' >>/etc/samba/smb.conf && \
	echo '' >>/etc/samba/smb.conf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*
#COPY samba.sh /usr/bin/

#VOLUME ["/etc/samba"]

#EXPOSE 137 139 445

#ENTRYPOINT ["samba.sh"]
