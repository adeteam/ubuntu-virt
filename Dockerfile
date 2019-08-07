FROM ubuntu:16.04
WORKDIR /tmp

RUN mkdir -p /opt/scripts
RUN mkdir -p /opt/vmware

COPY scripts/* /opt/scripts/
RUN chmod a+x /opt/scripts/*

COPY files/* ./

# install initial packages
RUN apt-get update -qq
RUN apt-get install -y sudo apt-utils apt-transport-https ca-certificates curl software-properties-common
RUN apt-get install -y git unzip tar coreutils qemu-utils open-vm-tools libpcsclite1 kmod libxinerama1 libxtst6 libxcursor1 libxi6 libfuse2 net-tools build-essential

# install packer
RUN curl https://releases.hashicorp.com/packer/1.4.2/packer_1.4.2_linux_amd64.zip --output ./packer.zip && unzip ./packer.zip -d /usr/bin/ && chmod a+x /usr/bin/packer

# install gcloud tools
RUN curl --output - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN add-apt-repository 'deb http://packages.cloud.google.com/apt cloud-sdk-xenial main'
RUN apt-get update -qq && apt-get install -y google-cloud-sdk

# extract the files
RUN cat ./vmware-workstation.tar.* | tar -xzvf - && mv ./VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle /opt/vmware/ && chmod a+x /opt/vmware/VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle

# remove unneeded libs
RUN apt-get remove -y --allow-remove-essential unzip
# cleanup apt cached files
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/
# cleanup temp files
RUN rm -rf ./*
