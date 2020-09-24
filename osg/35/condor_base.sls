include:
  - osg.35
  - osg.35.base_setup

condor-user-35:
  user.present:
    - name: condor
    - uid: 65
    - gid: 64

condor-base-35:
  pkg.latest:
    - pkgs:
      - condor
      - osg-release
      - osg-ca-certs
      - osg-ca-certs-updater
    - require:
      - osg_base_packages-35
      - condor-user-35
  file.managed:
    - name: /etc/condor/config.d/10-base.conf
    - source: salt://osg/35/files/condor/condor_base.conf
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/10-base.conf

condor-base-condor-password-file-35:
  file.managed:
    - name: /etc/condor/condor_password
    - source: salt://osg/35/files/condor/condor_password
    - mode: 600
