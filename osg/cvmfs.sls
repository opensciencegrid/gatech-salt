include:
  - osg
  - osg.base_setup

cvmfs-user:
  user.present:
    - name: cvmfs
    - uid: 486
    - gid: 486
  file.directory:
    - name: /scratch/cvmfs/cache
    - user: cvmfs
    - group: cvmfs
    - makedirs: True

cvmfs:
  pkg.latest:
    - pkgs:
      - osg-oasis
    - require:
      - pkg: osg_base_packages
      - cvmfs-user
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
