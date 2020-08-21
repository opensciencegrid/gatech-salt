x590-cert-dir-env-sh-35:
  file.managed:
    - name: /etc/profile.d/ldg-client.sh
    - source: salt://osg/35/files/ldg-client/ldg-client.sh
    - user: root
    - mode: 644

x590-cert-dir-env-csh-35:
  file.managed:
    - name: /etc/profile.d/ldg-client.csh
    - source: salt://osg/35/files/ldg-client/ldg-client.csh
    - user: root
    - mode: 644

lscsoft-production-repo-35:
  pkgrepo.managed:
    - name: lscsoft-production
    - humanname: lscsoft-production to install ldg-client
    - baseurl: http://software.ligo.org/lscsoft/scientific/$releasever/$basearch/production/
    - gpgcheck: 0
    - type: rpm-md

ldg-client-packages-install-35:
  pkg.latest:
    - pkgs:
      - ldg-client
      - ruby
      - ruby-devel
      - rubygem-json
    - require:
      - osg_base_packages-35
