osg35:
  pkgrepo.managed:
    - name: osg35-el7
    - humanname: OSG Software for Enterprise Linux 7 - $basearch
    - mirrorlist: https://repo.opensciencegrid.org/mirror/osg/3.5/el7/release/$basearch
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-OSG
    - consider_as_osg: yes
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-OSG
    - source: salt://osg/files/repos/RPM-GPG-KEY-OSG

osg_epel35:
  pkgrepo.managed:
    - name: epel-el7
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
    - consider_as_osg: yes
  file.managed:
    - name: /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
    - source: salt://osg/files/repos/RPM-GPG-KEY-EPEL-7
