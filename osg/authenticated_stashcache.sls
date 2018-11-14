include:
  - osg.base_setup
  - osg.host_certs
  - osg.stashcache_config

authenticated_stashcache:
  pkg.latest:
    - pkgs:
      - stashcache-daemon 
      - stashcache-cache-server
      - xrootd-lcmaps
      - globus-proxy-utils
    - require:
      - osg_base_packages
      - ca_certs

ligo_gridmap_cron:
  file.managed:
    - name: /etc/cron.d/generate_ligo_gridmap.cron
    - source: salt://osg/files/auth-stashcache/generate_ligo_gridmap.cron

ligo_gridmap_script:
  file.managed:
    - name: /usr/local/sbin/grid-mapfile.ligo-cvmfs.py
    - source: salt://osg/files/auth-stashcache/grid-mapfile.ligo-cvmfs.py
    - user: root
    - mode: 755

auth-stashcache-condor-service:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - authenticated_stashcache

auth-stashcache-xrootd-server-service:
  service.running:
    - name: xrootd@stashcache-cache-server-auth
    - enable: true
    - require:
      - authenticated_stashcache
      - user: ligo
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
      - authenticated_stashcache

    

