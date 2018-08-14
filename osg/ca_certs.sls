include:
  - osg.repos
  - osg.base_packages

ca_certs:
  pkg.latest:
    - fromrepo: osg34-el7
    - pkgs:
      - osg-ca-certs
    - require:
      - pkg: osg_base_packages

fetch-crl:
  pkg.installed: []

fetch-crl-cron:
  service.running:
    - enable: true
    - require:
      - pkg: fetch-crl

fetch-crl-boot:
  service.enabled:
    - name: fetch-crl-boot
    - require:
      - pkg: fetch-crl
