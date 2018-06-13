# Install RozoFS master branch

# Use the debian base image provided on Docker Hub
FROM debian:jessie
MAINTAINER kvaps, kvapss@gmail.com

# Make sure the package repository is up to date and install required packages
RUN apt-get -y update && apt-get install -y \
    wget \
    lsb-release \
    gnupg

# Avoid warning during packet installations
ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Install the release key
RUN wget -O - http://dl.rozofs.org/deb/devel@rozofs.com.gpg.key | apt-key add -

# Set the RozoFS repository to access RozoFS packages
RUN echo deb  http://dl.rozofs.org/deb/master $(lsb_release -sc) main | tee /etc/apt/sources.list.d/rozofs.list

# Install RozoFS manager (optionally) required for all nodes
RUN apt-get -y update && apt-get install -y \
    rozofs-manager*

CMD tail -f /var/log/dmesg
