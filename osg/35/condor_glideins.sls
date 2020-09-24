config-osgvo-node-advertise-35:
  file.managed:
    - name: /usr/bin/osgvo-node-advertise
    - source: salt://osg/35/files/glideins/osgvo-node-advertise
    - mode: 755

config-user-job-wrapper-35:
  file.managed:
    - name: /usr/libexec/condor/user-job-wrapper.sh
    - source: salt://osg/35/files/glideins/user-job-wrapper.sh
    - mode: 755

config-glidein-like-compute-node-35:
  file.managed:
    - name: /etc/condor/config.d/40-glidein-like-compute-node.conf
    - source: salt://osg/35/files/glideins/glidein-like-compute-node.conf
    - mode: 644

config-glideins-password-auth-35:
  file.managed:
    - name: /etc/condor/config.d/50-password-auth.conf
    - source: salt://osg/35/files/glideins/password-auth.conf
    - mode: 644
