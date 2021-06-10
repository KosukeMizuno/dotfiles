FROM centos:centos8.3.2011
LABEL maintainer "Kosuke Mizuno <dotmapu@gmail.com>"

RUN yum update -y
ENV TZ Asia/Tokyo

RUN yum groupinstall -y "Development Tools"
RUN yum install -y sudo git wget openssh tree man cmake yum-utils bash-completion

# python dependencies
## 名前解決がおかしくて失敗するやつが混ざってるので個別指定＆エラーを無視して進める
## 下記はpyenvのwikiから: https://github.com/pyenv/pyenv/wiki#suggested-build-environment
RUN yum install -y bzip2-devel bzip2 readline-devel sqlite sqlite-devel openssl-devel libffi-devel zlib-devel tk-devel xz-devel; \
    yum-builddep -y python3 ; exit 0

RUN yum clean all

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

WORKDIR /home/${USERNAME}/dotfiles
