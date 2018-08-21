include:
  - osg
  - osg.base_setup
  - osg.host_certs

stashcache:
  pkg.installed:
    - pkgs:
      - stashcache-daemon 
      - stashcache-cache-server
    - require:
      - pkg: osg_base_packages
      - pkg: ca_certs

stashcache-xrootd-config:
  file.managed:
    - name: /etc/xrootd/xrootd-stashcache-cache-server.cfg
    - source: salt://osg/files/stashcache/xrootd-stashcache-cache-server.cfg
      
stashcache-auth-config:
  file.managed:
    - name: /etc/xrootd/Authfile-noauth 
    - source: salt://osg/files/stashcache/Authfile
      
stashcache-robot-config:
  file.managed:
    - name: /etc/xrootd/stashcache-robots.txt 
    - source: salt://osg/files/stashcache/stashcache-robots.txt
      

stashcache-condor-service:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - pkg: stashcache-cache-server

stashcache-xrootd-server:
  service.running:
    - name: xrootd@stashcache-cache-server
    - enable: true
    - require:
      - pkg: stashcache-cache-server
      - pkg: stashcache-daemon
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stashcache-cache-server.cfg

