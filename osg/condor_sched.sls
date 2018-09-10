include:
  - osg
  - osg.base_setup

condor-sched:
  pkg.installed:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-base-local.conf
    - source: salt://osg/files/condor/condor_base.conf
  file.managed:
    - name: /etc/condor/config.d/99-sched-local.conf
    - source: salt://osg/files/condor/condor_sched.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/99-base-local.conf
      - file: /etc/condor/config.d/99-sched-local.conf
