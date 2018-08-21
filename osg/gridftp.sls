include:
  - osg
  - osg.base_setup
  - osg.host_certs

globus-gridftp-server:
  pkg.installed:
    - pkgs:
      - osg-gridftp
    - require:
      - pkg: osg_base_packages
      - pkg: ca_certs
  service.running:
    - enable: true
    - require:
      - pkg: osg-gridftp
