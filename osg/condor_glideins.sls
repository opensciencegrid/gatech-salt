config-osgvo-node-advertise:
  file.managed:
    - name: /usr/bin/osgvo-node-advertise
    - source: salt://osg/files/glideins/osgvo-node-advertise
    - mode: 755

config-user-job-wrapper:
  file.managed:
    - name: /usr/libexec/condor/user-job-wrapper.sh
    - source: salt://osg/files/glideins/user-job-wrapper.sh
    - mode: 755

config-glidein-like-compute-node:
  file.managed:
    - name: /etc/condor/config.d/40-glidein-like-compute-node.conf
    - source: salt://osg/files/glideins/glidein-like-compute-node.conf
    - mode: 644

config-glideins-password-auth:
  file.managed:
    - name: /etc/condor/config.d/50-password-auth.conf
    - source: salt://osg/files/glideins/password-auth.conf
    - mode: 644
