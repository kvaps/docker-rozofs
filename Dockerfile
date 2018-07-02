# Use the debian base image provided on Docker Hub
FROM debian:jessie

# Install tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Make sure the package repository is up to date and install required packages
RUN apt-get -y update && apt-get install -y \
    wget \
    lsb-release \
    gnupg

# Avoid warning during packet installations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install the release key
# Set the RozoFS repository to access RozoFS packages
# Install RozoFS manager (optionally) required for all nodes
RUN wget -O - http://dl.rozofs.org/deb/devel@rozofs.com.gpg.key | apt-key add - \
 && echo deb  http://dl.rozofs.org/deb/master $(lsb_release -sc) main | tee /etc/apt/sources.list.d/rozofs.list \
 && apt-get -y update \
 && apt-get install -y rozofs-manager*

# Make sure the package repository is up to date
RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01norecommend \
 && echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01norecommend \
 && apt-get -y update \
 && apt-get install -y rozofs-* busybox

ADD rozofs.sh /
CMD [ "/rozofs.sh" ]
