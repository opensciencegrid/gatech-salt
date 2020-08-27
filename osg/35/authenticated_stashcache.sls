include:
  - osg.35.base_setup
  - osg.35.host_certs
  - osg.35.stashcache
  - osg.35.stashcache_config

authenticated_stashcache-35:
  pkg.latest:
    - pkgs:
      - xrootd-lcmaps
      - globus-proxy-utils
    - require:
      - osg_base_packages-35
      - ca_certs-35
      - stashcache-osg35

ligo_gridmap_cron-35:
  file.managed:
    - name: /etc/cron.d/generate_ligo_gridmap.cron
    - source: salt://osg/35/files/auth-stashcache/generate_ligo_gridmap.cron

ligo_gridmap_script-35:
  file.managed:
    - name: /usr/local/sbin/grid-mapfile.ligo-cvmfs.py
    - source: salt://osg/35/files/auth-stashcache/grid-mapfile.ligo-cvmfs.py
    - user: root
    - mode: 755

auth-stashcache-condor-service-35:
  service.running:
    - name: condor 
    - enable: true
    - require:
      - authenticated_stashcache-35

auth-stashcache-xrootd-server-service-35:
  service.running:
    - name: xrootd@stash-cache-auth
    - enable: true
    - require:
      - authenticated_stashcache-35
      - user: xrootd
    - watch:
      - file: /etc/xrootd/Authfile-noauth
      - file: /etc/xrootd/xrootd-stash-cache-auth.cfg

auth-stashcache-register-timer-35:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /usr/lib/systemd/system/xrootd-renew-proxy.timer
      - file: /usr/lib/systemd/system/xrootd-renew-proxy.service


auth-stashcache-timer-service-35:
  service.running:
    - name: xrootd-renew-proxy.timer
    - enable: true
    - require:
      - authenticated_stashcache-35

    

