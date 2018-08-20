include:
  - osg
  - osg.base_setup

condor-submit:
  pkg.installed:
    - pkgs:
      - condor
    - fromrepo: osg34-el7
    - require:
      - pkg: osg_base_packages
  file.managed:
    - name: /etc/condor/config.d/99-submit-local.conf
    - source: salt://osg/files/condor/condor_submit.conf
  service.running:
    - enable: true
    - require:
      - pkg: condor
    - watch:
      - file: /etc/condor/config.d/99-submit-local.conf
