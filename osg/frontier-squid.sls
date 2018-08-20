include:
  - osg
  - osg.base_setup

frontier-squid:
  pkg.installed:
    - pkgs:
      - frontier-squid
    - fromrepo: osg34-el7
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
