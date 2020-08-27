include:
  - osg.35
  - osg.35.base_setup


squid-user-35:
  user.present:
    - name: squid
    - uid: 23
    - gid: 23

frontier-squid-35:
  pkg.latest:
    - pkgs:
      - frontier-squid
    - require:
      - pkg: osg_base_packages-35
  file.managed:
    - name: /etc/squid/customize.sh
    - source: salt://osg/35/files/frontier-squid/customize.sh

frontier-squid-service-35:
  service.running:
    - name: frontier-squid
    - enable: true
    - require:
      - pkg: frontier-squid-35
    - watch:
      - file: /etc/squid/customize.sh
