include:
  - osg
  - osg.base_setup

cvmfs:
  pkg.installed:
    - pkgs:
      - osg-oasis
    - require:
      - pkg: osg_base_packages
  file.managed:
    - name: /etc/cvmfs/default.local
    - source: salt://osg/files/cvmfs/cvmfs_local_config

autofs-osg:
  service.running:
    - name: autofs
    - enable: true
    - require:
      - cvmfs
  file.managed:
    - name: /etc/auto.master.d/cvmfs.autofs
    - source: salt://osg/files/cvmfs/autofs_config
