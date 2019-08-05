FROM ubuntu:16.04

WORKDIR /tmp
COPY files/* ./

RUN apt-get update -qq
RUN apt-get install -y sudo apt-utils apt-transport-https ca-certificates curl software-properties-common
RUN apt-get install -y zip unzip tar coreutils wget

# extract the files
RUN cat ./vmware-workstation.tar.* | tar -xzvf -
RUN chmod a+x ./VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle

# install packer
RUN curl https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip --output ./packer.zip
RUN unzip ./packer.zip -d /usr/bin/ && chmod a+x /usr/bin/packer

RUN mkdir -p /opt/vmware

# install vmware workstation
RUN apt-get install -y qemu-utils open-vm-tools libpcsclite1
RUN sudo ./VMware-Workstation-Full-14.0.0-6661328.x86_64.bundle --eulas-agreed --console --required -p /opt/vmware

RUN echo "export PATH=\"${PATH}:/opt/vmware/bin\"" >> /etc/bash.bashrc && echo "export PATH=\"${PATH}:/opt/vmware/sbin\"" >> /etc/bash.bashrc

# install gcloud tools
RUN wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN add-apt-repository 'deb http://packages.cloud.google.com/apt cloud-sdk-xenial main'
RUN apt-get update -qq && apt-get install -y google-cloud-sdk

# cleanup temp files
RUN rm -rf ./*
# cleanup apt cached files
RUN apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/
