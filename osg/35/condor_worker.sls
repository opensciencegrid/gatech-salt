include:
  - osg.35
  - osg.35.base_setup
  - osg.35.osg_users
  - osg.35.condor_base
  - osg.35.singularity_base
  - osg.35.condor_glideins
  - osg.35.condor_scratch

condor-worker-35:
  pkg.latest:
    - pkgs:
      - condor
      - osg-wn-client
    - require:
      - osg_base_packages-35
  file.managed:
    - name: /etc/condor/config.d/99-worker-local.conf
    - source: salt://osg/35/files/condor/condor_worker.conf
  service.running:
    - name: condor
    - enable: true
    - require:
      - condor-scratch-35
      - ligo-user-35
      - osg-user-35
      - icecube-user-35
      - veritas-user-35
      - cta-user-35
    - watch:
      - file: /etc/condor/config.d/99-worker-local.conf

condor-worker-singularity-conf-35:
  file.managed:
    - name: /etc/condor/config.d/95-singularity.conf
    - source: salt://osg/35/files/condor/condor_worker_singularity.conf
