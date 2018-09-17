include:
  - osg
  - osg.base_setup

cvmfs:
  pkg.installed:
    - pkgs:
      - osg-oasis
    - require:
      - pkg: osg_base_packages
      - user: cvmfs
  file.managed:
    - name: /etc/cvmfs/default.local
    - source: salt://osg/files/cvmfs/cvmfs_local_config

autofs-osg:
  service.running:
    - name: autofs
    - enable: true
    - require:
      - cvmfs
  file.line:
    - name: /etc/auto.master
    - content: "/cvmfs /etc/auto.cvmfs"
    - mode: ensure
    - after: "/nv     /etc/auto.nv"
