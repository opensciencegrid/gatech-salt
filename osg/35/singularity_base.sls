include:
  - osg.35
  - osg.35.base_setup

singularity_base-35:
  pkg.latest:
    - pkgs:
      - singularity: 3.6.1
    - require:
      - osg_base_packages-35
  file.managed:
    - name: /etc/singularity/singularity.conf
    - source: salt://osg/35/files/singularity/singularity.conf
