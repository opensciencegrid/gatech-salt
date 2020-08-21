include:
  - osg.35.base_setup

install_host_cert-35:
  file.managed:
    - name: /etc/grid-security/hostcert.pem
    - source: salt://osg/35/files/hostcerts/{{ grains['host'] }}/hostcert.pem
    - user: root
    - group: root
    - mode: 644

install_host_key-35:
  file.managed:
    - name: /etc/grid-security/hostkey.pem
    - source: salt://osg/35/files/hostcerts/{{ grains['host'] }}/hostkey.pem
    - user: root
    - group: root
    - mode: 400
