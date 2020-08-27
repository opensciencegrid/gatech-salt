include:
  - osg.35
  - osg.35.base_setup

cvmfs-user-35:
  user.present:
    - name: cvmfs
    - uid: 486
    - gid: 486
  file.directory:
    - name: /scratch/cvmfs/cache
    - user: cvmfs
    - group: cvmfs
    - makedirs: True

cvmfs-35:
  pkg.latest:
    - pkgs:
      - osg-oasis
    - require:
      - pkg: osg_base_packages-35
      - cvmfs-user-35
  file.managed:
    - name: /etc/cvmfs/default.local
    - source: salt://osg/35/files/cvmfs/cvmfs_local_config

autofs-osg-35:
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
