include:
  - osg.repos
  - osg.base_packages

condor-sched:
  pkg.installed:
    - pkgs:
      - condor
    - fromrepo: osg34-el7
    - require:
      - pkg: osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-sched-local.conf
    - source: salt://osg/files/condor/condor_sched.conf
  service.running:
    - enable: true
    - require:
      - pkg: condor
    - watch:
      - file: /etc/condor/config.d/99-sched-local.conf
