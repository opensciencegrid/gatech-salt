include:
  - osg.repos
  - osg.ca_certs

base_setup:
  pkg.latest:
    - fromrepo: osg34-el7
    - pkgs:
      - osg-ca-certs
    - require:
      - pkg: yum-plugin-priorities
 pkg.installed:
    - pkgs:
      - yum-plugin-priorities
      - fetch-crl
      - ntpd
 service.running:
    - enable: True
    - require:
      -pkg: ntpd
