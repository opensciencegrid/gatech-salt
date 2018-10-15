include:
  - osg
  - osg.base_setup
  - osg.condor_base

condor-scratch:
  file.directory:
    - name: /scratch
    - mode: 1777 

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
    - require:
      - condor-scratch
      - user: ligo
#      - user: gatech
#      - user: osg
    - watch:
      - file: /etc/condor/config.d/99-worker-local.conf
