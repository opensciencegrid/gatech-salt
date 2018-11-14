include:
  - osg
  - osg.base_setup
  - osg.host_certs


gridftp-lcmaps:
  file.managed:
    - name: /etc/lcmaps.db
    - source: salt://osg/files/gridftp/lcmaps.db
    - user: root
    - mode: 644

globus-gridftp-server:
  pkg.latest:
    - pkgs:
      - osg-gridftp
    - require:
      - osg_base_packages
      - ca_certs
  service.running:
    - enable: true
