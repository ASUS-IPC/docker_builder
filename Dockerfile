FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG userid
ARG groupid
ARG username

# Install required packages for building Tinker Edge R Android
# kmod: depmod is required by "make modules_install"
RUN apt-get update && apt-get install -y gawk wget git diffstat unzip \
    texinfo gcc-multilib build-essential chrpath socat cpio python python3 \
    python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git \
    python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm rsync curl locales \
    python-yaml

#Add for yocto-4.0
#RUN apt-get update && apt-get install -y zstd pzstd lz4c lz4 libssl-dev
RUN apt-get install -y zstd  liblz4-tool lz4
RUN apt-get update && apt-get install -y libssl-dev

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8

RUN groupadd -g $groupid $username && \
    useradd -m -u $userid -g $groupid $username && \
    echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo $username >/root/username

ENV HOME=/home/$username
ENV USER=$username
WORKDIR /source
