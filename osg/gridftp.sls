include:
  - osg
  - osg.base_setup
  - osg.host_certs

globus-gridftp-server:
  pkg.installed:
    - pkgs:
      - osg-gridftp
    - require:
      - osg_base_packages
      - ca_certs
  service.running:
    - enable: true
