include:
  - osg
  - osg.base_setup

condor-worker:
  pkg.installed:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-worker-local.conf
    - source: salt://osg/files/condor/condor_worker.conf
  service.running:
    - name: condor
    - enable: true
# include state that sets these users
#      - user: gatech
#      - user: ligo
#      - user; osg
    - watch:
      - file: /etc/condor/config.d/99-worker-local.conf
