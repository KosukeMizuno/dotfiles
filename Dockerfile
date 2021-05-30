FROM centos:centos8.3.2011
LABEL maintainer "Kosuke Mizuno <dotmapu@gmail.com>"

RUN yum update -y
ENV TZ Asia/Tokyo
RUN yum groupinstall -y "Development Tools"; yum install -y sudo git wget openssh ; yum clean all

# make a user who can sudo
ARG USERNAME=u1
ARG USERPASSWD=xxx

RUN useradd ${USERNAME} \
   && echo "root:${USERPASSWD}" | chpasswd \
   && echo "${USERNAME}:${USERPASSWD}" | chpasswd
RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USERNAME}
WORKDIR /home/${USERNAME}/

#### install tools ####
ENV DOTPATH /home/${USERNAME}/dotfiles

ENV PREFIX /home/${USERNAME}/.local
ENV PATH $PREFIX/.local/bin:$PATH
ENV LD_LIBRARY_PATH $PREFIX/.local/lib64:$PREFIX/.local/lib:/usr/lib64:/usr/lib:/lib64:/lib
ENV PKG_CONFIG_PATH $PREFIX/.local/lib64/pkgconfig:$PREFIX/lib/pkgconfig

RUN mkdir -p $PREFIX/src
WORKDIR $PREFIX/src

WORKDIR /home/${USERNAME}/dotfiles
RUN /home/${USERNAME}/dotfiles/bin/install.sh