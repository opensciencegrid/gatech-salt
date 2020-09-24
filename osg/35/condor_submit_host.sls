include:
  - osg.35
  - osg.35.base_setup
  - osg.35.osg_users
  - osg.35.condor_base
  - osg.35.singularity_base
  - osg.35.ldg_client_env

config-99-submit-local.conf-35:
  file.managed:
    - name: /etc/condor/config.d/99-submit-local.conf
    - source: salt://osg/35/files/condor/condor_submit_host.conf

config-condor_mapfile-35:
  file.managed:
    - name: /etc/condor/certs/condor_mapfile
    - source: salt://osg/35/files/hostcerts/osg-login2/condor_mapfile

config-ldg_accounting_script-35:
  file.managed:
    - name: /usr/bin/accounting
    - source: salt://osg/35/files/accounting/osg-login2/accounting
    - user: condor
    - group: condor
    - mode: 700

config-ldg_accounting_collector-35:
  file.managed:
    - name: /etc/default/ldg-accounting-collector
    - source: salt://osg/35/files/accounting/osg-login2/ldg-accounting-collector
    - user: condor
    - group: condor
    - mode: 644

ligo_accountin_cron-35:
  file.managed:
    - name: /etc/cron.d/ldg_accounting.cron
    - source: salt://osg/35/files/accounting/osg-login2/ldg_accounting.cron

config-condor_accounting_users-35:
  file.managed:
    - name: /usr/bin/condor_accounting_users
    - source: salt://osg/35/files/accounting/osg-login2/condor_accounting_users
    - user: root
    - group: root
    - mode: 755

config-condor_accounting_tags-35:
  file.managed:
    - name: /usr/bin/condor_accounting_tags
    - source: salt://osg/35/files/accounting/osg-login2/condor_accounting_tags
    - user: root
    - group: root
    - mode: 755

config-accounting-directory-35:
  file.directory:
    - name: /etc/condor/accounting
    - user: condor
    - group: condor
    - mode: 755

config-glideins-password-auth-submit-host-35:
  file.managed:
    - name: /etc/condor/config.d/50-password-auth.conf
    - source: salt://osg/35/files/glideins/password-auth.conf
    - mode: 644

voms-client-install-35:
  pkg.latest:
    - pkgs:
      - voms-clients-cpp.x86_64
    - fromrepo: osg35-el7

condor-submit-host-35:
  pkg.latest:
    - pkgs:
      - condor
      - osg-flock
      - glideinwms-userschedd
      - gratia-probe-condor
      - osg-configure-gratia
      - vo-client
      - htcondor-ce-client
    - require:
      - osg_base_packages-35
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/99-submit-local.conf
      - file: /etc/condor/certs/condor_mapfile

condor-submit-host-accounting-cron-35:
  cron.present:
    - name: /usr/bin/accounting
    - user: root
    - minute: 0
    - hour: 2


gratia-probe-config-35:
  file.managed:
    - name: /etc/gratia/condor/ProbeConfig
    - source: salt://osg/files/condor/ProbeConfig
    - user: root
    - mode: 644

gratia-probe-cron-service-35:
  service.running:
    - name: gratia-probes-cron
    - enable: true
    - watch: 
      - file: /etc/gratia/condor/ProbeConfig
