include:
  - osg.base_setup
  - osg.host_certs
  - osg.condor_submit

osg-ce:
  pkg.installed:
    - pkgs:
      - osg-ce-condor
    - require:
      - pkg: condor-submit

ce-config:
  file.managed:
    - name: /etc/osg/config.d/99-local.ini
    - source: salt://osg/files/ce/local.ini

osg-configure:
  cmd.run:
    - name: /usr/sbin/osg-configure -c
    - onchanges:
      - file: /etc/osg/config.d/99-local.ini

condor-ce:
  service.running:
    - name: condor-ce
    - enable: true
    - require:
      - pkg: osg-ce-condor
    - onchanges: 
      - file: /etc/osg/config.d/99-local.ini
