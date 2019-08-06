FROM ubuntu:16.04

RUN mkdir -p /opt/scripts
COPY scripts/* /opt/scripts/
RUN chmod a+x /opt/scripts/*

WORKDIR /tmp
COPY files/* ./

RUN apt-get update -qq
RUN apt-get install -y sudo apt-utils apt-transport-https ca-certificates curl software-properties-common
RUN apt-get install -y unzip tar coreutils qemu-utils open-vm-tools libpcsclite1 kmod libxinerama1 libxtst6 libxcursor1 libxi6 libfuse2 net-tools build-essential linux-headers-$(uname -r) linux-image-$(uname -r)

# extract the files
RUN cat ./vmware-workstation.tar.* | tar -xzvf - && chmod a+x ./VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle

# install packer
RUN curl https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip --output ./packer.zip && unzip ./packer.zip -d /usr/bin/ && chmod a+x /usr/bin/packer

# install vmware workstation
RUN sudo ./VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle --eulas-agreed --console --required

# install gcloud tools
RUN curl --output - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN add-apt-repository 'deb http://packages.cloud.google.com/apt cloud-sdk-xenial main'
RUN apt-get update -qq && apt-get install -y google-cloud-sdk

# remove unneeded libs
RUN apt-get remove -y --allow-remove-essential curl unzip
# cleanup apt cached files
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/
# cleanup temp files
RUN rm -rf ./*
