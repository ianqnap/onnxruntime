#!/bin/bash
set -e

yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

yum install -y redhat-lsb-core expat-devel libcurl-devel rpmdevtools tar unzip ccache curl zlib-devel make  python2-devel  libunwind icu aria2 rsync bzip2 git

#If the /opt/python folder exists, we assume this is the manylinux docker image
[ ! -d "/opt/python/cp35-cp35m" ] && yum install -y gcc gcc-c++ python3-devel python3-pip python3-numpy python3-setuptools python3-wheel