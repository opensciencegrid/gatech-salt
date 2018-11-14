include:
  - osg
  - osg.ca_certs
  - osg.base_packages

osg_ntpd_install:
  pkg.latest:
    - pkgs:
      - ntp

osg_ntpd_service:
 service.running:
    - name: ntpd
    - enable: True
    - require:
      - osg_ntpd_install


