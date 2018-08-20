include:
  - osg.base_setup
  - osg.host_certs

authenticated_stashcache:
  pkg.installed:
    - pkgs:
      - stashcache-daemon 
      - stashcache-cache-server
      - xrootd-lcmaps
      - globus-proxy-utils
    - fromrepo: osg34-el7
    - require:
      - pkg: osg_base_packages
      - pkg: ca_certs
      - base_setup

auth-stashcache-xrootd-config:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server.cfg
    - source: salt://osg/files/auth-stashcache/xrootd-stashcache-cache-server.cfg
      
auth-stashcache-auth-config:
  file.managed:
    - name: /etc/xrootd/Authfile-noauth 
    - source: salt://osg/files/auth-stashcache/Authfile
      
auth-stashcache-robot-config:
  file.managed:
    - name: /etc/xrootd/stashcache-robots.txt 
    - source: salt://osg/files/auth-stashcache/stashcache-robots.txt
     
auth-stashcache-config-symlink:
{% if not salt['file.file_exists' ]('/etc/xrootd/xrootd-stashcache-cache-server-auth.cfg') %}
    file.symlink:
      - name: /etc/xrootd/xrootd-stashcache-cache-server.cfg
      - target: /etc/xrootd/xrootd-stashcache-cache-server-auth.cfg
{% endif %}

proxy-timer-service-file:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.timer
    - source: salt://osg/files/auth-stashcache/xrootd-renew-proxy.timer
     
proxy-service-file:
  file.managed:
    - name: /usr/lib/systemd/system/xrootd-renew-proxy.service
    - source: salt://osg/files/auth-stashcache/xrootd-renew-proxy.service
     

auth-stashcache-condor-service:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - pkg: stashcache-cache-server

auth-stashcache-xrootd-server-service:
  service.running:
    - name: xrootd@stashcache-cache-server-auth
    - enable: true
    - require:
      - pkg: stashcache-cache-server
      - pkg: stashcache-daemon
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stashcache-cache-server.cfg

auth-stashcache-register-timer:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /usr/lib/systemd/system/xrootd-renew-proxy.timer
      - file: /usr/lib/systemd/system/xrootd-renew-proxy.service


auth-stashcache-timer-service:
  service.running:
    - name: xrootd-renew-proxy.timer
    - enable: true
    - require:
      - pkg: stashcache-cache-server
      - pkg: stashcache-daemon

    

