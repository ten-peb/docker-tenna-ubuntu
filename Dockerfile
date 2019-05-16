FROM ubuntu:18.04
MAINTAINER Peter L. Berghold <pberghold@tenna.com>
LABEL build build-2019-05-15
##
## Update the OS
RUN  export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y dist-upgrade && \
     apt-get -y install wget curl apt-utils build-essential gcc make git \
                ntp
# Set the timezone correctly to America/New_york
RUN export DEBIAN_FRONTEND=noninteractive && \
    echo $TZ > /etc/timezone && \
    apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata



## Grab the Puppet repository configuration
# Grab the repository definition(s) for Puppet products 
RUN wget --quiet --no-verbose \
         http://apt.puppetlabs.com/puppet-release-bionic.deb
RUN dpkg -i puppet-release-bionic.deb

## Install the Puppet agent, Nagios NRPE and Nagios plugins

RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y install \ 
                        nagios-nrpe-server \
                        monitoring-plugins monitoring-plugins-basic \
			nagios-plugins-contrib puppet-agent

