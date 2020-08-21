include:
  - osg.35
  - osg.35.ca_certs
  - osg.35.base_packages

osg_ntpd_install-35:
  pkg.latest:
    - pkgs:
      - ntp

osg_ntpd_service-35:
 service.running:
    - name: ntpd
    - enable: True
    - require:
      - osg_ntpd_install-35


