FROM ubuntu:16.04

RUN apt-get update -qq
RUN apt-get install -y apt-utils apt-transport-https ca-certificates curl software-properties-common
RUN apt-get install -y zip unzip

# install packer
RUN curl https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip --output /tmp/packer.zip
RUN unzip /tmp/packer.zip -d /usr/bin/
RUN chmod a+x /usr/bin/packer

RUN mkdir -p /opt/vmware

# install vmware workstation
RUN apt-get install -y qemu-utils open-vm-tools libpcsclite1
RUN curl https://www.filehosting.org/file/details/814965/VMware-Player-14.0.0-6661328.x86_64.bundle --output /tmp/vmware-workstation.bundle
RUN chmod a+x /tmp/vmware-workstation.bundle
RUN sudo /tmp/vmware-workstation.bundle --eulas-agreed --console --required -p /opt/vmware

# install ovftool
RUN curl https://www.filehosting.org/file/details/814969/VMware-ovftool-4.3.0-7948156-lin.x86_64.bundle --output /tmpf/vmware-ovftool.bundle
RUN chmod a+x /tmp/vmware-ovftool.bundle
RUN sudo /tmp/vmware-ovftool.bundle --eulas-agreed --console --required -p /opt/vmware

RUN echo "export PATH=\"${PATH}:/opt/vmware/bin\"" >> /etc/bash.bashrc
RUN echo "export PATH=\"${PATH}:/opt/vmware/sbin\"" >> /etc/bash.bashrc

# install gcloud tools
RUN wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN add-apt-repository 'deb http://packages.cloud.google.com/apt cloud-sdk-xenial main'
RUN apt-get update -qq
RUN apt-get install -y google-cloud-sdk
