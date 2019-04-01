include:
  - osg
  - osg.base_setup
  - osg.condor_base

condor-sched:
  pkg.latest:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-sched-local.conf
    - source: salt://osg/files/condor/condor_sched.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/99-sched-local.conf

config-glideins-password-auth-sched:
  file.managed:
    - name: /etc/condor/config.d/50-password-auth.conf
    - source: salt://osg/files/glideins/password-auth.conf
    - mode: 644
