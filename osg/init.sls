osg:
  pkgrepo.managed:
    - name: osg34-el7
    - humanname: OSG Software for Enterprise Linux 7 - $basearch
    - mirrorlist: https://repo.opensciencegrid.org/mirror/osg/3.4/el7/release/$basearch
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-OSG
    - consider_as_osg: yes
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-OSG
    - source: salt://osg/files/repos/RPM-GPG-KEY-OSG
