include:
  - osg
  - osg.base_setup

condor-user:
  user.present:
    - name: condor
    - uid: 65
    - gid: 64

condor-base:
  pkg.installed:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
      - condor-user
  file.managed:
    - name: /etc/condor/config.d/10-base.conf
    - source: salt://osg/files/condor/condor_base.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/10-base.conf
