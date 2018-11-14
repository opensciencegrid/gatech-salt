include:
  - osg
  - osg.base_packages

ca_certs:
  pkg.latest:
    - pkgs:
      - osg-ca-certs
    - require:
      - pkg: osg_base_packages

fetch-crl:
  pkg.latest: []

fetch-crl-cron:
  service.running:
    - enable: true
    - require:
      - pkg: fetch-crl
  file.managed:
    - name: /etc/cron.d/fetch-crl
    - source: salt://osg/files/ca/fetch-crl

fetch-crl-boot:
  service.enabled:
    - name: fetch-crl-boot
    - require:
      - pkg: fetch-crl

