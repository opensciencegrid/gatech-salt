include:
  - osg
  - osg.base_setup

condor-base:
  pkg.installed:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
      - user: condor
  file.managed:
    - name: /etc/condor/config.d/10-base.conf
    - source: salt://osg/files/condor/condor_base.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/10-base.conf
