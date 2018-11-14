include:
  - osg
  - osg.base_setup
  - osg.host_certs
  - osg.stashcache_config

xrootd-user:
  user.present:
    - name: xrootd
    - uid: 1115
    - gid: 2115

stashcache:
  pkg.latest:
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
      - xrootd-user
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stashcache-cache-server.cfg

