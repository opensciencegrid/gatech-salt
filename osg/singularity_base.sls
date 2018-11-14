include:
  - osg
  - osg.base_setup

singularity_base:
  pkg.latest:
    - pkgs:
      - singularity
      - singularity-runtime
    - require:
      - osg_base_packages
  file.managed:
    - name: /etc/singularity/singularity.conf
    - source: salt://osg/files/singularity/singularity.conf
