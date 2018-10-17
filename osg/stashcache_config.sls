include:
  - osg.base_setup
  - osg.host_certs

stashcache-cache-dir:
  file.directory:
    - name: /var/cache/xrootd
    - mode: 700
    - user: xrootd

stashcache-xrootd-lcmaps:
  file.managed:
    - name: /etc/xrootd/lcmaps.cfg
    - source: salt://osg/files/auth-stashcache/lcmaps.cfg

stashcache-xrootd-config:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server.cfg
    - source: salt://osg/files/auth-stashcache/xrootd-stashcache-cache-server.cfg
      
stashcache-xrootd-config-auth:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server-auth.cfg
    - source: salt://osg/files/auth-stashcache/xrootd-stashcache-cache-server.cfg

stashcache-auth-config:
  file.managed:
    - name: /etc/xrootd/Authfile-auth 
    - source: salt://osg/files/auth-stashcache/Authfile-auth
      
stashcache-noauth-config:
  file.managed:
    - name: /etc/xrootd/Authfile-noauth 
    - source: salt://osg/files/stashcache/Authfile-noauth
      
stashcache-robot-config:
  file.managed:
    - name: /etc/xrootd/stashcache-robots.txt 
    - source: salt://osg/files/auth-stashcache/stashcache-robots.txt
     
proxy-timer-service-file:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.timer
    - source: salt://osg/files/auth-stashcache/xrootd-renew-proxy.timer
     
proxy-service-file:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.service
    - source: salt://osg/files/auth-stashcache/xrootd-renew-proxy.service

stashcache-certdir:
  file.directory:
    - name: /etc/grid-security/xrd/
    - mode: 755
    - user: xrootd
    - group: xrootd

stashcache-hostkey:
  file.managed:
    - name: /etc/grid-security/xrd/xrdkey.pem
    - source: salt://osg/files/hostcerts/osg-gftp/hostkey.pem
    - user: xrootd
    - mode: 400

stashcache-hostcert:
  file.managed:
    - name: /etc/grid-security/xrd/xrdcert.pem
    - source: salt://osg/files/hostcerts/osg-gftp/hostcert.pem
    - user: xrootd
