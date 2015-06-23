#!/bin/sh

################################################################################
# RASPICAM-APACHE INSTALLATION SCRIPT
#
# Copyright (c) 2014,2015 Jérémie DECOCK <jd.jdhp@gmail.com> (www.jdhp.org)
# 
# The MIT license
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
################################################################################

# INSTALL APACHE WEB SERVER

if [ "$(dpkg -l | grep apache2 | head -c2)" != "ii" ]
then
    echo "Installing apache2..."
    aptitude update
    aptitude install apache2
fi


# WARNING MESSAGE

echo
echo "WARNING:"
echo "Please make sure raspicam has been enabled with raspi-config and enough memory has been allocated to GPU." 
read FOO


# TODO: if the script is run by an other user than root, this user have to be added to "video" group in order to access the picamera
# adduser <USERNAME> video


# WRITE THE CAPTURE SCRIPT

cp ./usr/sbin/raspicam-apache /usr/sbin/raspicam-apache

# Only root should be allowed to execute this script
chmod 744 /usr/sbin/raspicam-apache


# INIT SCRIPT
#
# Upstart is not installed by default on Raspbian... so let's use init script instead.
# See: /init.d/skeleton
#      /init.d/README
#      http://www.debian.org/doc/debian-policy/ch-opersys.html#s-sysvinit (http://www.debian.org/doc/debian-policy/#contents  chapter "System run levels and init.d scripts")
#      http://raspberrywebserver.com/serveradmin/run-a-script-on-start-up.html
#      http://blog.scphillips.com/2013/07/getting-a-python-script-to-run-in-the-background-as-a-service-on-boot/
#
# warning: /init.d/skeleton example doesn't run services in background...

cp ./etc/init.d/raspicam-apache /etc/init.d/
chmod 744 /etc/init.d/raspicam-apache

update-rc.d raspicam-apache defaults


# CONFIGURE APACHE

# Write the default web page
cat > /var/www/index.html << EOF
<html>
    <head>
        <!-- Reload all by itself every 3 seconds -->
        <meta http-equiv="refresh" content="3">
    </head>
    <body>
        <h1>Raspicam @ $(cat /etc/hostname)</h1>
        <img src="raspicam.jpeg" />
    </body>
</html>
EOF

ln --symbolic /run/raspicam.jpeg /var/www/raspicam.jpeg


