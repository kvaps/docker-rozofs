# Dockerizing RozoFS: Dockerfile for building rozofs-storaged images
# Based on rozofs-base, itself based on the official Debian image
# Installs rozofs-storaged following the instructions from:
# http://rozofs.github.io/rozofs/master/InstallingRozoFS.html

# Based on the rozofs-base image provided by kvaps
FROM kvaps/rozofs-base
MAINTAINER kvaps, kvapss@gmail.com

# Installation:
# Make sure the package repository is up to date before installing storaged
RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01norecommend \
 && echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01norecommend \
 && apt-get -y update \
 && apt-get install -y rozofs-storaged busybox

ADD rozofs-storaged.sh rozofs-agent.sh /

# Expose port 51000 from the container to the host
# storio, the storaged sub-process requires to expose port 41001 to
# be linked to stocli (sub-process of rozofsmount)
EXPOSE 51000 41001

ENTRYPOINT [ "/rozofs-storaged.sh" ]
