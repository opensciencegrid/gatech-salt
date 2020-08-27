include:
  - osg
  - osg.base_setup
  - osg.condor_base
  - osg.singularity_base

lscsoft-production-repo:
  pkgrepo.managed:
    - name: lscsoft-production
    - humanname: lscsoft-production to install ldg-client
    - baseurl: http://software.ligo.org/lscsoft/scientific/$releasever/$basearch/production/
    - gpgcheck: 0
    - type: rpm-md

condor-submit:
  pkg.latest:
    - pkgs:
      - condor
      - ldg-client
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