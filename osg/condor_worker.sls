include:
  - osg
  - osg.base_setup
  - osg.condor_base
  - osg.singularity_base
  - osg.condor_glideins

condor-scratch:
  file.directory:
    - name: /scratch
    - mode: 1777 

ligo-user:
  user.present:
    - name: ligo
    - uid: 488
    - gid: 178

osg-user:
  user.present:
    - name: osg
    - uid: 1111
    - gid: 2111

icecube-user:
  user.present:
    - name: icecube
    - uid: 1112
    - gid: 2112

veritas-user:
  user.present:
    - name: veritas
    - uid: 1113
    - gid: 2113

cta-user:
  user.present:
    - name: cta
    - uid: 1114
    - gid: 2114

condor-worker:
  pkg.latest:
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
      - ligo-user
      - osg-user
      - icecube-user
      - veritas-user
      - cta-user
    - watch:
      - file: /etc/condor/config.d/99-worker-local.conf

condor-worker-singularity-conf:
  file.managed:
    - name: /etc/condor/config.d/95-singularity.conf
    - source: salt://osg/files/condor/condor_worker_singularity.conf
