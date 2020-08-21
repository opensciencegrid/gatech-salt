include:
  - osg.35
  - osg.35.base_packages

ca_certs-35:
  pkg.latest:
    - pkgs:
      - osg-ca-certs
    - require:
      - pkg: osg_base_packages-35

osg-pki-tools-35:
  pkg.latest:
    - pkgs:
      - osg-pki-tools
    - require:
      - pkg: osg_base_packages-35

fetch-crl-35:
  pkg.latest:
    - pkgs:
      - fetch-crl
    - require:
      - pkg: osg_base_packages-35

fetch-crl-cron-35:
  service.running:
    - name: fetch-crl-cron
    - enable: true
    - require:
      - pkg: fetch-crl-35
  file.managed:
    - name: /etc/cron.d/fetch-crl
    - source: salt://osg/files/ca/fetch-crl

fetch-crl-boot-35:
  service.enabled:
    - name: fetch-crl-boot
    - require:
      - pkg: fetch-crl-35

