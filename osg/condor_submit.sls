include:
  - osg
  - osg.base_setup
  - osg.condor_base

condor-submit:
  pkg.installed:
    - pkgs:
      - condor
    - require:
      - osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-submit-local.conf
    - source: salt://osg/files/condor/condor_submit.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/99-submit-local.conf
