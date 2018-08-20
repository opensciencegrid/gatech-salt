include:
  - osg.base_setup

install_host_cert:
  file.managed:
    - name: /etc/grid-security/hostcert.pem
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/hostcert.pem
    - user: root
    - group: root
    - mode: 644

install_host_key:
  file.managed:
    - name: /etc/grid-security/hostcert.pem
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/hostkey.pem
    - user: root
    - group: root
    - mode: 400
