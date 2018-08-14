include:
  - osg.repos
  - osg.base_packages
  - osg.ca_certs

globus-gridftp-server:
  pkg.installed:
    - pkgs:
      - osg-gridftp
    - fromrepo: osg34-el7
    - require:
      - pkg: osg_base_packages
      - pkg: ca_certs
  service.running:
    - enable: true
    - require:
      - pkg: osg-gridftp
