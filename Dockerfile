FROM ubuntu:18.04
MAINTAINER Peter L. Berghold <pberghold@tenna.com>
LABEL build-2019-05-15
##
## Update the OS
RUN  export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y dist-upgrade && \
     apt-get -y install wget curl apt-utils build-essential gcc make git \
                ntp

## Grab the Puppet repository configuration
# Grab the repository definition(s) for Puppet products 
RUN wget --quiet --no-verbose \
         http://apt.puppetlabs.com/puppet-release-bionic.deb
RUN dpkg -i puppet-release-bionic.deb

## Install the Puppet agent, Nagios NRPE and Nagios plugins

RUN export DEBIAN_FRONTEND=noninteractive && \
     apt-get update && \
     apt-get -y install puppet-agent nagios-nrpe-server \
                        monitoring-plugins monitoring-plugins-basic \
			nagios-plugins-contrib 

