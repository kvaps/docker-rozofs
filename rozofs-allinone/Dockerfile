# Set RozoFS all-in-one container

# Use rozofs-base image provided by kvaps
FROM kvaps/rozofs-base
MAINTAINER kvaps, kvapss@gmail.com

ENV DEBIAN_FRONTEND noninteractive
# Allow services to start after installation
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Make sure the package repository is up to date
RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/01norecommend \
 && echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01norecommend \
 && apt-get -y update \
 && apt-get install -y rozofs-* busybox

ADD rozofs-agent.sh /

EXPOSE 50027 51000 50028 41001 50000 53000 52000 50003 50004

ENTRYPOINT [ "/rozofs-agent.sh" ]
