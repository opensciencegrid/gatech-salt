include:
  - osg
  - osg.base_setup
  - osg.host_certs


shib-repo:
  pkgrepo.managed:
    - name: shib-el7
    - humanname: Shibboleth (CentOS_7)
    - baseurl: http://download.opensuse.org/repositories/security:/shibboleth/CentOS_7/
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-SHIBBOLETH
    - type: rpm-md
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-SHIBBOLETH
    - source: salt://osg/files/repos/RPM-GPG-KEY-SHIBBOLETH

shib-httpd-conf:
  file.managed:
    - name: /etc/httpd/conf.d/shib.conf
    - source: salt://osg/files/httpd/shib.conf

shib-userdir-conf:
  file.managed:
    - name: /etc/httpd/conf.d/userdir.conf
    - source: salt://osg/files/httpd/userdir.conf

shib-ssl-conf:
  file.managed:
    - name: /etc/httpd/conf.d/ssl.conf
    - source: salt://osg/files/httpd/ssl.conf_new

shib-ssl-cert:
  file.managed:
    - name: /etc/pki/tls/certs/osg-shibboleth.pace.gatech.edu.pem
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/hostcert.pem
    - user: apache
    - group: apache
    - mode: 640

shib-ssl-key:
  file.managed:
    - name: /etc/pki/tls/private/osg-shibboleth.pace.gatech.edu.key.pem
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/hostkey.pem
    - user: apache
    - group: apache
    - mode: 600

shib-ssl-cert-new:
  file.managed:
    - name: /etc/pki/tls/certs/osg-shibboleth.pace.gatech.edu.cer
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/osg-shibboleth.pace.gatech.edu.cer
    - user: apache
    - group: apache
    - mode: 640

shib-ssl-key-new:
  file.managed:
    - name: /etc/pki/tls/private/osg-shibboleth.pace.gatech.edu.key
    - source: salt://osg/files/hostcerts/{{ grains['host'] }}/osg-shibboleth.pace.gatech.edu.key
    - user: apache
    - group: apache
    - mode: 600

shib-conf-shibboleth2:
  file.managed:
    - name: /etc/shibboleth/shibboleth2.xml
    - source: salt://osg/files/shibboleth/shibboleth2.xml

shib-conf-attribute-map:
  file.managed:
    - name: /etc/shibboleth/attribute-map.xml
    - source: salt://osg/files/shibboleth/attribute-map.xml

osg-shibboleth-cert:
  file.managed:
    - name: /etc/shibboleth/sp-cert.pem
    - source: salt://osg/files/httpd/selfsignedcert.pem
    - user: shibd
    - group: shibd
    - mode: 640

osg-shibboleth-key:
  file.managed:
    - name: /etc/shibboleth/sp-key.pem
    - source: salt://osg/files/httpd/selfsignedkey.pem
    - user: shibd
    - group: shibd
    - mode: 600

osg-shibboleth-identityid-cert:
  file.managed:
    - name: /etc/shibboleth/login.ligo.org.cert.LIGOCA.pem
    - source: salt://osg/files/shibboleth/login.ligo.org.cert.LIGOCA.pem
    - user: shibd
    - group: shibd
    - mode: 644

osg-shibboleth-service:
  pkg.latest:
    - name: shibboleth
  service.running:
    - enable: true
    - name: shibd
    - watch:
      - file: /etc/shibboleth/login.ligo.org.cert.LIGOCA.pem
      - file: /etc/shibboleth/shibboleth2.xml
      - file: /etc/shibboleth/attribute-map.xml

osg-shibboleth-httpd:
  pkg.latest:
    - pkgs:
      - httpd
      - mod_ssl
  service.running:
    - enable: true
    - name: httpd
    - watch:
      - file: /etc/httpd/conf.d/shib.conf
      - file: /etc/httpd/conf.d/userdir.conf
      - file: /etc/httpd/conf.d/ssl.conf
    - require:
      - osg-shibboleth-service

mount-ligo-web-nfs:
  mount.mounted:
    - name: /mnt/ligo_web
    - device: gpfs-nfs4-vip.pace.gatech.edu:/gpfs/pace1/project/pligo/web/LIGO
    - fstype: nfs
    - mkmnt: True
    - persist: True
    - opts:
      - ro,vers=3,rsize=32786,wsize=32786

mount-ligo-web-nfs-sghonge3-scratch:
  mount.mounted:
    - name: /mnt/sghonge3_scratch
    - device: gpfs-nfs4-vip.pace.gatech.edu:/gpfs/scratch1/3/sghonge3
    - fstype: nfs
    - mkmnt: True
    - persist: True
    - opts:
      - ro,vers=3,rsize=32786,wsize=32786