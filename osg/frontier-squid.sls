include:
  - osg
  - osg.base_setup

frontier-squid:
  pkg.latest:
    - pkgs:
      - frontier-squid
    - require:
      - pkg: osg_base_packages
  file.managed:
    - name: /etc/squid/customize.sh
    - source: salt://osg/files/frontier-squid/customize.sh
  service.running:
    - enable: true
    - require:
      - pkg: frontier-squid
    - watch:
      - file: /etc/squid/customize.sh
