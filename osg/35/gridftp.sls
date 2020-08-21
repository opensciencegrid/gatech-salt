include:
  - osg
  - osg.35.base_setup
  - osg.35.host_certs
  - osg.35.ldg_client_env


gridftp-lcmaps-35:
  file.managed:
    - name: /etc/lcmaps.db
    - source: salt://osg/35/files/gridftp/lcmaps.db
    - user: root
    - mode: 644


globus-gridftp-server-35:
  pkg.latest:
    - pkgs:
      - osg-gridftp
      - ldg-client
    - require:
      - osg_base_packages-35
      - ca_certs-35
  service.running:
    - enable: true
