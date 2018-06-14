# Dockerizing RozoFS: Dockerfile for building rozofs-exportd images
# Based on rozofs-base, itself based on the official Debian image
# Installs rozofs-exportd following the instructions from:
# http://rozofs.github.io/rozofs/master/InstallingRozoFS.html

# Based on the rozofs-base image provided by kvaps
FROM kvaps/rozofs-base
MAINTAINER kvaps, kvapss@gmail.com

# Installation:
# Make sure the package repository is up to date before installing storaged
RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01norecommend \
 && echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01norecommend \
 && apt-get -y update \
 && apt-get install -y rozofs-exportd busybox

ADD rozofs-exportd.sh /

# Expose port 53000 from the container to the host
EXPOSE 53000

ENTRYPOINT [ "/rozofs-exportd.sh" ]
