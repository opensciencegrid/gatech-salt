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
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-SHIBBOLETH
    - type: rpm-md
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-SHIBBOLETH
    - source: salt://osg/files/repos/RPM-GPG-SHIBBOLETH

osg-shibboleth-httpd:
  pkg.installed:
    - pkgs:
      - httpd
  file.managed:
    - name: /etc/httpd/conf.d/shib.conf
    - source: salt://osg/files/httpd/shib.conf
  service.running:
    - enable: true
    - watch:
      - file: /etc/httpd/conf.d/shib.conf
