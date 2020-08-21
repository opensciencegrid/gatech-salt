include:
  - osg.35.base_setup
  - osg.35.host_certs

xrootd-user-osg35:
  user.present:
    - name: xrootd
    - uid: 1115
    - gid: 2115

stashcache-cache-dir-zfs-35:
  file.directory:
    - name: /stashcache/xrootd
    - mode: 700
    - user: xrootd

stashcache-cache-dir-35:
  file.symlink:
    - name: /var/cache/xrootd
    - target: /stashcache/xrootd
    - mode: 700
    - user: xrootd

stashcache-xrootd-etc-dir-35:
  file.directory:
    - name: /etc/xrootd
    - mode: 0755
    - user: root
    - group: root

stashcache-xrootd-lcmaps-35:
  file.managed:
    - name: /etc/xrootd/lcmaps.cfg
    - source: salt://osg/35/files/auth-stashcache/lcmaps.cfg

stashcache-xrootd-config-old-35:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server.cfg
    - source: salt://osg/35/files/auth-stashcache/xrootd-stashcache-cache-server.cfg
      
stashcache-xrootd-config-35:
  file.managed:
    - name: /etc/xrootd/xrootd-stash-cache.cfg
    - source: salt://osg/35/files/stashcache/xrootd-stash-cache.cfg
      
stashcache-xrootd-config-auth-old-35:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server-auth.cfg
    - source: salt://osg/35/files/auth-stashcache/xrootd-stashcache-cache-server.cfg

stashcache-xrootd-config-auth-35:
  file.managed:
    - name: /etc/xrootd/xrootd-stash-cache-auth.cfg
    - source: salt://osg/35/files/auth-stashcache/xrootd-stash-cache-auth.cfg

stashcache-auth-config-35:
  file.managed:
    - name: /etc/xrootd/Authfile-auth 
    - source: salt://osg/35/files/auth-stashcache/Authfile-auth
      
stashcache-noauth-config-35:
  file.managed:
    - name: /etc/xrootd/Authfile-noauth 
    - source: salt://osg/35/files/stashcache/Authfile-noauth
      
stashcache-robot-config-35:
  file.managed:
    - name: /etc/xrootd/stashcache-robots.txt 
    - source: salt://osg/35/files/auth-stashcache/stashcache-robots.txt
     
proxy-timer-service-file-35:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.timer
    - source: salt://osg/35/files/auth-stashcache/xrootd-renew-proxy.timer
     
proxy-service-file-35:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.service
    - source: salt://osg/35/files/auth-stashcache/xrootd-renew-proxy.service

stashcache-certdir-35:
  file.directory:
    - name: /etc/grid-security/xrd/
    - mode: 755
    - user: xrootd
    - group: xrootd

stashcache-hostkey-35:
  file.managed:
    - name: /etc/grid-security/xrd/xrdkey.pem
    - source: salt://osg/35/files/hostcerts/{{ grains['host'] }}/hostkey.pem
    - user: xrootd
    - mode: 400

stashcache-hostcert-35:
  file.managed:
    - name: /etc/grid-security/xrd/xrdcert.pem
    - source: salt://osg/35/files/hostcerts/{{ grains['host'] }}/hostcert.pem
    - user: xrootd

stashcache-fqdn-dir-35:
  file.directory:
    - name: /usr/lib/systemd/system/stash-cache-authfile.service.d
    - user: root
    - group: root
    - mode: 0644

stashcache-fqdn-35:
  file.managed:
    - name: /usr/lib/systemd/system/stash-cache-authfile.service.d/override.conf
    - source: salt://osg/35/files/auth-stashcache/override.conf
    - user: root
    - group: root
    - mode: 0644
