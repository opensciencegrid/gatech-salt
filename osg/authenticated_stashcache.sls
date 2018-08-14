include:
  - osg.repos
  - osg.base_packages
  - osg.ca_certs

authenticated_stashcache:
  pkg.installed:
    - pkgs:
      - stashcache-daemon 
      - stashcache-cache-server
      - xrootd-lcmaps 
      - globus-proxy-utils
    - fromrepo: osg34-el7
    - require:
      - pkg: osg_base_packages
      - pkg: ca_certs
  service.running:
    - enable: true
    - require:
      - pkg: osg-gridftp
