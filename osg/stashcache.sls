include:
  - osg
  - osg.base_setup
  - osg.host_certs
  - osg.stashcache_config

stashcache:
  pkg.installed:
    - pkgs:
      - stashcache-daemon 
      - stashcache-cache-server
    - require:
      - osg_base_packages
      - ca_certs

stashcache-condor-service:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - stashcache

stashcache-xrootd-server:
  service.running:
    - name: xrootd@stashcache-cache-server
    - enable: true
    - require:
      - stashcache
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stashcache-cache-server.cfg

