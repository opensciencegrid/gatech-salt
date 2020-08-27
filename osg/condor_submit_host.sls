include:
  - osg
  - osg.base_setup
  - osg.condor_base
  - osg.singularity_base
  - osg.ldg_client_env

config-99-submit-local.conf:
  file.managed:
    - name: /etc/condor/config.d/99-submit-local.conf
    - source: salt://osg/files/condor/condor_submit_host.conf

config-condor_mapfile:
  file.managed:
    - name: /etc/condor/certs/condor_mapfile
    - source: salt://osg/files/hostcerts/osg-login1/condor_mapfile

config-ldg_accounting_script:
  file.managed:
    - name: /usr/bin/accounting
    - source: salt://osg/files/accounting/osg-login1/accounting
    - user: condor
    - group: condor
    - mode: 700

config-ldg_accounting_collector:
  file.managed:
    - name: /etc/default/ldg-accounting-collector
    - source: salt://osg/files/accounting/osg-login1/ldg-accounting-collector
    - user: condor
    - group: condor
    - mode: 644

ligo_accountin_cron:
  file.managed:
    - name: /etc/cron.d/ldg_accounting.cron
    - source: salt://osg/files/accounting/osg-login1/ldg_accounting.cron

config-condor_accounting_users:
  file.managed:
    - name: /usr/bin/condor_accounting_users
    - source: salt://osg/files/accounting/osg-login1/condor_accounting_users
    - user: root
    - group: root
    - mode: 755

config-condor_accounting_tags:
  file.managed:
    - name: /usr/bin/condor_accounting_tags
    - source: salt://osg/files/accounting/osg-login1/condor_accounting_tags
    - user: root
    - group: root
    - mode: 755

config-accounting-directory:
  file.directory:
    - name: /etc/condor/accounting
    - user: condor
    - group: condor
    - mode: 755

config-glideins-password-auth-submit-host:
  file.managed:
    - name: /etc/condor/config.d/50-password-auth.conf
    - source: salt://osg/files/glideins/password-auth.conf
    - mode: 644


condor-submit-host:
  pkg.latest:
    - pkgs:
      - condor
      - glideinwms-userschedd
      - gratia-probe-condor
      - osg-configure-gratia
      - vo-client
    - require:
      - osg_base_packages
  service.running:
    - name: condor
    - enable: true
    - watch:
      - file: /etc/condor/config.d/99-submit-local.conf
      - file: /etc/condor/certs/condor_mapfile

condor-submit-host-accounting-cron:
  cron.present:
    - name: /usr/bin/accounting
    - user: root
    - minute: 0
    - hour: 2


gratia-probe-config:
  file.managed:
    - name: /etc/gratia/condor/ProbeConfig
    - source: salt://osg/files/condor/ProbeConfig
    - user: root
    - mode: 644

gratia-probe-cron-service:
  service.running:
    - name: gratia-probes-cron
    - enable: true
    - watch: 
      - file: /etc/gratia/condor/ProbeConfig
