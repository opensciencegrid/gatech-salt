include:
  - osg.35
  - osg.35.osg_users
  - osg.35.base_setup
  - osg.35.host_certs
  - osg.35.stashcache_config

xrootd-osg35:
  pkg.installed:
    - pkgs:
      - python2-xrootd: 1:4.11.3-1.2.osg35.el7
      - xrootd: 1:4.11.3-1.2.osg35.el7
      - xrootd-client-libs: 1:4.11.3-1.2.osg35.el7
      - xrootd-lcmaps: 1.7.5-1.osg35.el7
      - xrootd-libs: 1:4.11.3-1.2.osg35.el7
      - xrootd-selinux: 1:4.11.3-1.2.osg35.el7
      - xrootd-server: 1:4.11.3-1.2.osg35.el7
      - xrootd-server-libs: 1:4.11.3-1.2.osg35.el7
    - fromrepo: osg35-el7

stashcache-osg35:
  pkg.latest:
    - pkgs:
      - stash-cache
    - require:
      - pkg: osg_base_packages-35
      - pkg: ca_certs-35
      - pkg: xrootd-osg35

stashcache-condor-service-osg35:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - stashcache-osg35

stashcache-xrootd-server-osg35:
  service.running:
    - name: xrootd@stash-cache
    - enable: true
    - require:
      - stashcache-osg35
      - xrootd-user-osg35
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stash-cache.cfg

