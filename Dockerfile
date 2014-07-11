# Base ubuntu image without doc directories

FROM ubuntu:14.04
MAINTAINER Hugo Duncan <hugo@palletops.com>

# Add filters for documentation
ADD dpkg_nodoc /etc/dpkg/dpkg.cfg.d/01_nodoc
ADD dpkg_nolocales /etc/dpkg/dpkg.cfg.d/01_nolocales
ADD apt_nocache /etc/apt/apt.conf.d/02_nocache
ADD remove_doc.sh /usr/local/bin/remove_doc

RUN /usr/local/bin/remove_doc
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoremove
RUN DEBIAN_FRONTEND=noninteractive apt-get -y autoclean
RUN DEBIAN_FRONTEND=noninteractive apt-get -y clean
